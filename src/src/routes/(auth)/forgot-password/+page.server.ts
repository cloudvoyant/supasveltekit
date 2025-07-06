// src/routes/+page.server.ts
import { fail, redirect } from '@sveltejs/kit';
import type { Actions, PageServerLoad } from './$types';
import type { EmailOtpType } from '@supabase/supabase-js';

export const load: PageServerLoad = async ({ url, locals: { safeGetSession } }) => {
	const { session } = await safeGetSession();

	// if the user is already logged in return them to the account page
	if (session) {
		redirect(303, '/');
	}

	return { url: url.toString() };
};

export const actions: Actions = {
	recover: async (event) => {
		const {
			request,
			locals: { supabase }
		} = event;
		const formData = await request.formData();
		const email = formData.get('email') as string;
		const validEmail = /^[\w-\.+]+@([\w-]+\.)+[\w-]{2,8}$/.test(email);

		if (!validEmail) {
			return fail(400, { errors: { email: 'Please enter a valid email address' }, email });
		}

		const { error } = await supabase.auth.resetPasswordForEmail(email);

		if (error) {
			console.log(error);
			return fail(400, {
				success: false,
				email,
				message: `Invalid account credentials.`
			});
		}

		return {
			success: true,
			message: 'Check your email for further instructions.'
		};
	},
	reset: async (event) => {
		const {
			request,
			locals: { supabase }
		} = event;
		const formData = await request.formData();
		const password = (formData.get('password') ?? '') as string;
		const recoveryCode = formData.get('recovery-code') as string | undefined;
		const methodType = formData.get('method-type') as EmailOtpType | null;
		const validPassword =
			/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/.test(password);

		if (!validPassword) {
			return fail(400, {
				errors: {
					password:
						'Password must be at least eight characters long, inlcude one uppercase letter, one lowercase letters, one number and one special character.'
				}
			});
		}

		if (!recoveryCode || !methodType) {
			console.warn('Recovery code or method type not provided through password reset form.');
			return fail(400, {
				success: false,
				message: 'Something went wrong. Try again later.'
			});
		}

		const otpRes = await supabase.auth.verifyOtp({
			type: methodType,
			token_hash: recoveryCode
		});
		if (otpRes.error) {
			return fail(400, {
				success: false,
				message: 'Your recovery code may have expired. Try again with a new code.'
			});
		}

		const updateRes = await supabase.auth.updateUser({
			password
		});
		if (updateRes.error) {
			console.log(updateRes.error);
			return fail(400, {
				success: false,
				message: `Password could not be updated.`
			});
		}

		return {
			success: true,
			message: 'Your password has been reset.'
		};
	}
};
