import { redirect } from '@sveltejs/kit';
import { PUBLIC_ENABLE_SIGNUP } from '$env/static/public';
import type { PageServerLoad } from './$types';
import type { Actions } from '@sveltejs/kit';
import { fail } from '@sveltejs/kit';

export const load: PageServerLoad = async () => {
	// Redirect to login if signup is disabled
	if (PUBLIC_ENABLE_SIGNUP === 'false') {
		redirect(303, '/login');
	}

	return {};
};

export const actions: Actions = {
	default: async (event) => {
		const {
			request,
			locals: { supabase }
		} = event;
		const formData = await request.formData();
		const email = formData.get('email') as string;
		const password = formData.get('password') as string;
		const passwordRepeated = formData.get('password-repeated') as string;
		const validEmail = /^[\w-\.+]+@([\w-]+\.)+[\w-]{2,8}$/.test(email);

		if (!validEmail) {
			return fail(400, { errors: { email: 'Please enter a valid email address' } });
		}

		if (password != passwordRepeated) {
			return fail(400, { errors: { 'password-repeated': 'Passwords do not matc' } });
		}

		const { error } = await supabase.auth.signUp({ email, password });

		if (error) {
			console.log(error);
			return fail(400, {
				success: false,
				email,
				message: `There was an issue, Please contact support.`
			});
		}

		redirect(303, '/');
	}
};
