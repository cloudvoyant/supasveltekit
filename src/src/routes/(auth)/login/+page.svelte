<script lang="ts">
	import { Button } from "$lib/components/ui/button/index.js";
	import * as Card from "$lib/components/ui/card/index.js";
	import { Input } from "$lib/components/ui/input/index.js";
	import { Label } from "$lib/components/ui/label/index.js";
    import { PUBLIC_ENABLE_SIGNUP } from "$env/static/public";

	const id = $props.id();
    let { data, form } = $props();
</script>

<div class="flex w-full flex-1 items-center justify-center px-4">
    <Card.Root class="mx-auto w-full max-w-sm">
        <form method="POST">
            <Card.Header>
                <Card.Title class="text-2xl text-center">Log in</Card.Title>
                <Card.Description>Enter your email below to login to your account</Card.Description>
            </Card.Header>
            <Card.Content>
                {#if !form?.success}
                    <p class="error">{form?.message}</p>
                {/if}
                <div class="grid gap-4">
                    <div class="grid gap-2">
                        <Label for="email-{id}">Email</Label>
                        <Input id="email-{id}" type="email" name="email" placeholder="you@example.com" required />
                    </div>
                    <div class="grid gap-2">
                        <div class="flex items-center">
                            <Label for="password-{id}">Password</Label>
                            <a href="/forgot-password" class="ml-auto inline-block text-sm underline">
                                Forgot your password?
                            </a>
                        </div>
                        <Input id="password-{id}" type="password" name="password" required />
                    </div>
                    <Button type="submit" class="w-full">Login</Button>
                    <Button variant="outline" href="/passwordless-login" class="w-full" >
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">                          
                            <!-- Envelope Background -->
                            <rect x="2" y="4" width="20" height="16" rx="2" ry="2" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            
                            <!-- Envelope Flap -->
                            <path d="M2 6L12 13L22 6" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
                          </svg>
                        Login with magic link
                    </Button>
                    <Button variant="outline" class="w-full">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                            <path
                                d="M12.48 10.92v3.28h7.84c-.24 1.84-.853 3.187-1.787 4.133-1.147 1.147-2.933 2.4-6.053 2.4-4.827 0-8.6-3.893-8.6-8.72s3.773-8.72 8.6-8.72c2.6 0 4.507 1.027 5.907 2.347l2.307-2.307C18.747 1.44 16.133 0 12.48 0 5.867 0 .307 5.387.307 12s5.56 12 12.173 12c3.573 0 6.267-1.173 8.373-3.36 2.16-2.16 2.84-5.213 2.84-7.667 0-.76-.053-1.467-.173-2.053H12.48z"
                                fill="currentColor"
                            />
                        </svg>
                        Login with Google
                    </Button>
                </div>
                {#if (PUBLIC_ENABLE_SIGNUP === 'true')}
                <div class="mt-4 text-center text-sm">
                    Don't have an account?
                    <a href="/signup" class="underline"> Sign up </a>
                </div>
                {/if}
            </Card.Content>
        </form>
    </Card.Root>
</div>
