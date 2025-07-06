<script lang="ts">
	import '../app.css'
	import { invalidate } from '$app/navigation'
	import { onMount } from 'svelte'
	import * as NavigationMenu from "$lib/components/ui/navigation-menu/index.js";
	import * as ScrollArea from '$lib/components/ui/scroll-area/scroll-area.svelte';
	import * as DropdownMenu from "$lib/components/ui/dropdown-menu/index.js";
	import * as Avatar from "$lib/components/ui/avatar/index.js";
	import Button from '$lib/components/ui/button/button.svelte';

	export let data

	let { supabase, session } = data
	$: ({ supabase, session } = data)

	onMount(() => {
		const { data } = supabase.auth.onAuthStateChange((event, newSession) => {
			if (newSession?.expires_at !== session?.expires_at) {
				invalidate('supabase:auth')
			}
		})

		return () => data.subscription.unsubscribe()
	})
</script>

<svelte:head>
	<title>SupaKit</title>
</svelte:head>

<div class="w-screen h-screen overflow-clip flex flex-col items-stretch">
	<NavigationMenu.Root class="px-2 py-1 border-b max-w-full flex-0 justify-start content-stretch">
		<NavigationMenu.List>
			<NavigationMenu.Item class="cursor-pointer">
				<NavigationMenu.Link
					href="/"
					class="flex h-10 w-10 items-center justify-center">
					<img src="/svg/supakit-logo.svg" alt="SupaKit" class="h-10 w-10 max-w-none" />
				</NavigationMenu.Link>
			</NavigationMenu.Item>
		</NavigationMenu.List>
		<div class="flex-1"></div>
		{#if session}
			<!-- Avatar Dropdown Menu -->
			<DropdownMenu.Root>
				<DropdownMenu.Trigger class="flex h-10 w-10 rounded-full items-center justify-center cursor-pointer hover:bg-accent" >
					<Avatar.Root class="h-8 w-8">
						<Avatar.Image src="/svg/profile-default.svg" alt="Profile" />
						<Avatar.Fallback>
							<img class="h-4 w-4" src="/svg/profile-default.svg" alt="Profile" />
						</Avatar.Fallback>
					</Avatar.Root>
				</DropdownMenu.Trigger>
				<DropdownMenu.Content align="end" class="w-48">
						<!-- Logged in - show user options -->
						<DropdownMenu.Item>
							<a href="/account" class="w-full">Account</a>
						</DropdownMenu.Item>
						<DropdownMenu.Separator />
						<DropdownMenu.Item variant="destructive">
							<form method="POST" action="/logout?/logout" class="w-full">
								<button type="submit" class="w-full text-left">Log out</button>
							</form>
						</DropdownMenu.Item>
				</DropdownMenu.Content>
			</DropdownMenu.Root>
		{:else}
			<Button href="/login">Log in</Button>
		{/if}
	</NavigationMenu.Root>
	
	<div class="flex flex-col flex-1 overflow-clip">
		<slot />
	</div>
</div>
