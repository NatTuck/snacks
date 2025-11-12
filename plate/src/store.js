import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { loginUser } from './api';

export const useStore = create(
  persist(
    (set) => ({
      session: null, // { user: object, token: string } or null
      snacks: [],    // Array of snack objects.

      login: async (email, password) => {
        try {
          // loginUser now returns { user, token, snacks }
          const loginData = await loginUser(email, password);
          console.log("Login response data:", loginData);

          // Update store: session gets user/token, snacks gets the list
          set({
            session: { user: loginData.user, token: loginData.token },
            snacks: loginData.snacks || [] // Use received snacks or empty array
          });

          return loginData; // Return full data for potential use in component
        } catch (error) {
          console.error("Login failed in store:", error);
          // Clear session and snacks on error
          set({ session: null, snacks: [] });
          throw error; // Re-throw error to be caught by the component
        }
      },

      logout: () => {
        set({ session: null, snacks: [] });
      },

      addSnack: (snack) => {
        set((state) => {
          const currentSnacks = Array.isArray(state.snacks) ? state.snacks : [];
          return { snacks: [...currentSnacks, snack] };
        });
      },

      removeSnack: (id) => {
        set((state) => ({
          snacks: (Array.isArray(state.snacks) ? state.snacks : []).filter(snack => snack.id !== id)
        }));
      },
    }),
    {
      // Persist whole store in localStorage.
      name: 'fridge-storage',
    }
  )
);
