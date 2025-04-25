import NextAuth from 'next-auth';

declare module 'next-auth' {
  interface Session {
    user: {
      id: string;
      email: string;
      name: string;
      role: string;
      accessToken: string;
      image?: string | null;
    }
  }

  interface User {
    id: string;
    email: string;
    name: string;
    role: string;
    token: string;
  }
}

declare module 'next-auth/jwt' {
  interface JWT {
    role: string;
    accessToken: string;
  }
} 