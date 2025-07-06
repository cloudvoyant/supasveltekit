<!-- src/routes/account/+page.svelte -->
<script lang="ts">
	import { enhance } from '$app/forms';
    import { Button } from "$lib/components/ui/button/index.js";
    import * as Card from "$lib/components/ui/card/index.js";
	import type { SubmitFunction } from '@sveltejs/kit';
    import { Input } from "$lib/components/ui/input/index.js";
	import { Label } from "$lib/components/ui/label/index.js";

	export let data
	export let form

	let { session, supabase, profile } = data
	$: ({ session, supabase, profile } = data)

	let profileForm: HTMLFormElement
	let loading = false
	let fullName: string = profile?.full_name ?? ''
	let username: string = profile?.username ?? ''
	let website: string = profile?.website ?? ''
	let avatarUrl: string = profile?.avatar_url ?? ''

	const handleSubmit: SubmitFunction = () => {
		loading = true
		return async () => {
			loading = false
		}
	}
</script>

<div class="flex h-screen w-full items-center justify-center px-4">
    <Card.Root class="mx-auto w-full max-w-sm">
        <form
            class="form-widget"
            method="POST"
            action="?/update"
            use:enhance={handleSubmit}
            bind:this={profileForm}
        >
            <Card.Header>
                <Card.Title class="text-2xl">Profile</Card.Title>
            </Card.Header>
            <Card.Content>
                {#if !form?.success}
                    <p class="error">{form?.message}</p>
                {:else if form?.success}
                    <p class="success">{form?.message}</p>
                {/if}

                <div class="grid gap-4">
                    <div>
                        <Label for="email">Email</Label>
                        <Input id="email" type="text" value={session.user.email} disabled />
                    </div>
            
                    <div>
                        <Label for="fullName">Full Name</Label>
                        <Input id="fullName" name="fullName" type="text" value={form?.fullName ?? fullName} />
                    </div>
            
                    <div>
                        <Label for="username">Username</Label>
                        <Input id="username" name="username" type="text" value={form?.username ?? username} />
                    </div>
            
                    <div>
                        <Label for="website">Website</Label>
                        <Input id="website" name="website" type="url" value={form?.website ?? website} />
                    </div>

                    <Button type="submit" class="w-full" disabled={loading}>{loading ? 'Loading...' : 'Update'}</Button>
                </div>
            </Card.Content>
        </form>
    </Card.Root>
</div>
