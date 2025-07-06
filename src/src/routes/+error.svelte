<script lang="ts">
	import { page } from '$app/stores';
	import { Button } from "$lib/components/ui/button/index.js";
</script>

<svelte:head>
	<title>Error - SupaKit</title>
</svelte:head>

<div class="flex min-h-full flex-col items-center justify-center px-4 py-16">
	<div class="mx-auto max-w-4xl text-center">
		<!-- Error Logo -->
		<div class="mb-8 flex justify-center">
			<img src="/svg/supakit-logo.svg" alt="SupaKit" class="h-24 w-24 opacity-75" />
		</div>

		<!-- Error Title -->
		<h1 class="mb-6 text-4xl font-bold tracking-tight text-gray-900 sm:text-6xl">
			{$page.status}
		</h1>

		<!-- Error Message -->
		<p class="mb-8 text-lg leading-8 text-gray-600 sm:text-xl">
			{$page.error?.message || 'Something went wrong'}
		</p>

		<!-- Error Details Card -->
		<div class="mb-10 mx-auto max-w-md">
			<div class="rounded-lg border border-red-200 bg-red-50 p-6">
				<h3 class="font-semibold text-red-900 mb-2">
					{#if $page.status === 404}
						Page Not Found
					{:else if $page.status === 500}
						Internal Server Error
					{:else if $page.status >= 400 && $page.status < 500}
						Client Error
					{:else if $page.status >= 500}
						Server Error
					{:else}
						Unexpected Error
					{/if}
				</h3>
				<p class="text-sm text-red-700">
					{#if $page.status === 404}
						The page you're looking for doesn't exist or has been moved.
					{:else if $page.status === 500}
						We're experiencing technical difficulties. Please try again later.
					{:else if $page.status >= 400 && $page.status < 500}
						There was a problem with your request. Please check and try again.
					{:else if $page.status >= 500}
						Our servers are having trouble. We're working to fix this.
					{:else}
						An unexpected error occurred. Please try again.
					{/if}
				</p>
			</div>
		</div>

		<!-- Action Buttons -->
		<div class="flex flex-col gap-4 sm:flex-row sm:justify-center">
			<Button class="text-lg px-8 py-3">
				<a href="/">Go Home</a>
			</Button>
			<Button variant="outline" class="text-lg px-8 py-3">
				<a href="javascript:history.back()">Go Back</a>
			</Button>
		</div>
	</div>
</div>