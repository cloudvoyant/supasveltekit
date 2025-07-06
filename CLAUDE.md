# SvelteKit + Supabase Project

## Project Overview
This is a SvelteKit application integrated with Supabase for authentication and user management. The project includes magic link authentication, user profiles, and a complete auth flow.

## Key Technologies
- **Frontend**: SvelteKit 2.x with TypeScript and Svelte 5
- **Styling**: Tailwind CSS 4.x with custom components
- **UI Components**: shadcn-svelte (bits-ui) + custom UI components
- **Backend**: Supabase (Authentication, Database, Storage)
- **Testing**: Vitest + Testing Library
- **Deployment**: Adapter Node.js

## Project Structure
```
src/
├── src/
│   ├── routes/              # SvelteKit routes
│   │   ├── (auth)/         # Authentication routes group
│   │   │   ├── login/      # Login page
│   │   │   ├── signup/     # Signup page  
│   │   │   ├── account/    # User account management
│   │   │   ├── logout/     # Logout functionality
│   │   │   ├── confirm/    # Email confirmation
│   │   │   └── forgot-password/ # Password reset
│   │   └── +page.svelte    # Home page (magic link auth)
│   ├── lib/
│   │   ├── components/ui/  # shadcn-svelte UI components
│   │   ├── supabase/       # Supabase client & utilities
│   │   └── utils.ts        # Utility functions
│   └── app.html            # App shell
├── static/
│   └── svg/               # Custom logos (supakit, supabase, sveltekit)
├── supabase/              # Supabase configuration
│   ├── migrations/        # Database migrations
│   └── config.toml        # Supabase config
└── package.json
```

## Development Commands
- `npm run dev` - Start development server
- `npm run build` - Build for production  
- `npm run preview` - Preview production build
- `npm run check` - TypeScript + Svelte checks
- `npm run lint` - ESLint + Prettier checks
- `npm run format` - Format code with Prettier
- `npm run test` - Run unit tests
- `npm run test:unit` - Run tests in watch mode

## Authentication Flow
- **Home page** (`/`) - Magic link email authentication
- **Login** (`/login`) - Traditional email/password login
- **Signup** (`/signup`) - User registration
- **Account** (`/account`) - Profile management (requires auth)
- **Logout** (`/logout`) - Sign out functionality
- **Confirm** (`/confirm`) - Email confirmation handler
- **Forgot Password** (`/forgot-password`) - Password reset

## Key Files & Patterns
- `hooks.server.ts` - Server-side Supabase auth handling
- `app.d.ts` - TypeScript declarations for Supabase locals
- `+layout.server.ts` - Session management for all routes
- `(auth)` route group - Protected authentication routes
- Form actions use `enhance` for progressive enhancement

## Supabase Integration
- Client configured in `src/lib/supabase/`
- SSR-compatible auth with `@supabase/ssr`
- Available via `locals.supabase` in server code
- Session available via `locals.safeGetSession()`
- Database includes `profiles` table for user data

## UI Components
- Custom shadcn-svelte components in `src/lib/components/ui/`
- Tailwind CSS for styling with custom configuration
- Responsive design patterns
- Form validation and error handling

## Database Schema
- `profiles` table linked to Supabase auth users
- Auto-created profile on user signup via trigger
- Fields: `id`, `username`, `full_name`, `website`, `avatar_url`, `updated_at`

## Development Notes
- Uses TypeScript throughout
- Follows SvelteKit conventions for file-based routing
- Server-side form actions for auth operations
- Progressive enhancement with JavaScript
- Tailwind classes for styling
- Error handling with form validation

## Environment Setup
Ensure `.env.local` contains:
- `PUBLIC_SUPABASE_URL`
- `PUBLIC_SUPABASE_ANON_KEY`
- `SUPABASE_SERVICE_ROLE_KEY`

## Deployment
- Configured for Node.js deployment with `@sveltejs/adapter-node`
- Build artifacts in `build/` directory
- Static assets served from `static/`
- Supabase handles backend infrastructure