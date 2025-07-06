<script lang="ts">
	import { enhance } from '$app/forms'
	import type { ActionData, SubmitFunction } from './$types.js'
	import { Button } from "$lib/components/ui/button/index.js";
	import * as Card from "$lib/components/ui/card/index.js";
	import { Input } from "$lib/components/ui/input/index.js";
	import { Label } from "$lib/components/ui/label/index.js";

	export let form: ActionData;

	let loading = false

	const handleSubmit: SubmitFunction = () => {
		loading = true
		return async ({ update }) => {
			update()
			loading = false
		}
	}
</script>

<svelte:head>
	<title>Passwordless Login</title>
</svelte:head>

<div class="flex h-screen w-full items-center justify-center px-4">
	<Card.Root class="mx-auto w-full max-w-sm">
		<form method="POST" use:enhance={handleSubmit}>
			<Card.Header>
				<Card.Title class="text-2xl text-center">Passwordless Login</Card.Title>
				<Card.Description>Sign in via magic link sent to your email.</Card.Description>
			</Card.Header>
			<Card.Content>
				{#if form?.message !== undefined}
					{#if !form?.success}
						<p class="error">{form?.message}</p>
					{:else if form?.success}
						<p class="success">{form?.message}</p>
					{/if}
				{/if}

				<div class="grid gap-4">
					<div class="grid gap-2">
						<Label for="email">Email</Label>
						<Input 
							id="email" 
							type="email" 
							name="email" 
							placeholder="you@example.com" 
							value={form?.email ?? ''}
							required 
						/>
						{#if form?.errors?.email}
							<span class="flex items-center text-sm error">
								{form?.errors?.email}
							</span>
						{/if}
					</div>
					<Button type="submit" class="w-full" disabled={loading}>
						{loading ? 'Loading...' : 'Send magic link'}
					</Button>
				</div>
			</Card.Content>
		</form>
	</Card.Root>
</div>