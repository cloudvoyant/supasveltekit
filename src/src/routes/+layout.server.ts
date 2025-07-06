// from: https://supabase.com/docs/guides/getting-started/tutorials/with-sveltekit

import type { LayoutServerLoad } from './$types';

export const load: LayoutServerLoad = async ({ locals: { safeGetSession }, cookies }) => {
	const { session, user } = await safeGetSession();

	return {
		session,
		user,
		cookies: cookies.getAll()
	};
};
