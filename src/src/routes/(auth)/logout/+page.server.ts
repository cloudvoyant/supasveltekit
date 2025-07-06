// from: https://supabase.com/docs/guides/getting-started/tutorials/with-sveltekit

import { redirect } from '@sveltejs/kit';
import type { Actions } from './$types';

export const actions: Actions = {
	logout: async ({ locals: { supabase, safeGetSession } }) => {
		const { session } = await safeGetSession();
		if (session) {
			await supabase.auth.signOut();
			redirect(303, '/');
		}
	}
};
