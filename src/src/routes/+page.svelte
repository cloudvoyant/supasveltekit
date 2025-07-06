<script lang="ts">
	import { Button } from "$lib/components/ui/button/index.js";
</script>

<svelte:head>
	<title>SupaKit</title>
</svelte:head>

<div class="flex min-h-full flex-col items-center justify-center px-4 py-16">
	<div class="mx-auto max-w-4xl text-center">
		<!-- Hero Logo -->
		<div class="mb-8 flex justify-center">
			<img src="/svg/supakit-logo.svg" alt="SupaKit" class="h-24 w-24" />
		</div>

		<!-- Hero Title -->
		<h1 class="mb-6 text-4xl font-bold tracking-tight text-gray-900 sm:text-6xl">
			Welcome to <span class="text-orange-600">SupaKit</span>
		</h1>

		<!-- Hero Description -->
		<p class="mb-8 text-lg leading-8 text-gray-600 sm:text-xl">
			A feature-rich Sveltekit+Supabase starter template.
		</p>

		<!-- Feature List -->
		<div class="mb-10 grid grid-cols-1 gap-4 text-left sm:grid-cols-2 lg:grid-cols-3">
			<div class="rounded-lg border p-4">
				<h3 class="font-semibold text-gray-900">Authentication</h3>
				<p class="text-sm text-gray-600">Done right from the get-go</p>
			</div>
			<div class="rounded-lg border p-4">
				<h3 class="font-semibold text-gray-900">Supabase</h3>
				<p class="text-sm text-gray-600">For auth, persistence and realtime</p>
			</div>
			<div class="rounded-lg border p-4">
				<h3 class="font-semibold text-gray-900">Shadcd-Svelte + Tailwind</h3>
				<p class="text-sm text-gray-600">For your UI and styling needs</p>
			</div>
			<div class="rounded-lg border p-4">
				<h3 class="font-semibold text-gray-900">Terraform</h3>
				<p class="text-sm text-gray-600">For Infrastructure-as-Code</p>
			</div>
			<div class="rounded-lg border p-4">
				<h3 class="font-semibold text-gray-900">GCP CloudRun</h3>
				<p class="text-sm text-gray-600">Easy containerized deployments</p>
			</div>
			<div class="rounded-lg border p-4">
				<h3 class="font-semibold text-gray-900">GitHub Actions</h3>
				<p class="text-sm text-gray-600">For CI/CD</p>
			</div>
		</div>

		<!-- Link to docs -->
		<div class="flex flex-col gap-4 sm:flex-row sm:justify-center">
			<Button class="text-lg px-8 py-3">
				<a href="/signup">Read The Docs</a>
			</Button>
		</div>
	</div>
</div>