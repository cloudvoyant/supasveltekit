<script lang="ts">
	import { page } from "$app/state";
    import type { PageProps } from "./$types";
	import { Button } from "$lib/components/ui/button/index.js";
	import * as Card from "$lib/components/ui/card/index.js";
	import { Input } from "$lib/components/ui/input/index.js";
	import { Label } from "$lib/components/ui/label/index.js";

	const id = $props.id();
    let { data, form }: PageProps = $props();
    console.log(data.url)
    let recoveryCode = $derived(new URL(data.url).searchParams?.get("recovery_code"));
    console.log('recovery code:', recoveryCode)
    let methodType = $derived(new URL(data.url).searchParams?.get("type"));
    console.log('method type:', methodType);
</script>

<div class="flex h-screen w-full items-center justify-center px-4">
    <Card.Root class="mx-auto w-full max-w-sm">
        <form method="POST" action="?/{recoveryCode ? 'reset' : 'recover'}">
            <Card.Header>
                <Card.Title class="text-2xl text-center">Password Recovery</Card.Title>
                <Card.Description>Enter your email below to reset your password</Card.Description>
            </Card.Header>
            <Card.Content>
                {#if !form?.success}
                    <p class="error">{form?.message}</p>
                {:else if form?.success}
                    <p class="success">{form?.message}</p>
                {/if}

                {#if recoveryCode }
                    <div class="grid gap-4">
                        <div class="grid gap-2">
                            <Label for="email-{id}">New Password</Label>
                            <Input id="email-{id}" type="password" name="password" placeholder="you@example.com" required />
                        </div>
                        <div class="grid gap-2">
                            <Label for="password-{id}">Re-enter New Password</Label>
                            <Input id="repeat-password-{id}" type="password" name="repeat-password" placeholder="you@example.com" required />
                        </div>
                        <Input type="hidden" name="recovery-code" required value={recoveryCode}/>
                        <Input type="hidden" name="method-type" required value={methodType}/>
                        <Button type="submit" class="w-full">Update My Password</Button>
                    </div>
                    <div class="mt-4 text-center text-sm">
                        Login with a magic link instead?
                        <a href="/passwordless-login" class="underline"> Email me! </a>
                    </div>
                {:else}
                    <div class="grid gap-4">
                        <div class="grid gap-2">
                            <Label for="email-{id}">Email</Label>
                            <Input id="email-{id}" type="email" name="email" placeholder="you@example.com" required />
                        </div>
                        <Button type="submit" class="w-full">Reset My Password</Button>
                    </div>
                    <div class="mt-4 text-center text-sm">
                        Login with a magic link instead?
                        <a href="/passwordless-login" class="underline"> Email me! </a>
                    </div>
                {/if}
            </Card.Content>
        </form>
    </Card.Root>
</div>
