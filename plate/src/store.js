import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { loginUser } from './api'; // Import the API function

export const useStore = create(
  persist(
    (set) => ({
      session: null, // Will store { user: object, token: string } or null
      snacks: [],

      // New async login action
      login: async (email, password) => {
        try {
          const sessionData = await loginUser(email, password); // Call API
          set({ session: sessionData }); // Update store on success { user: ..., token: ... }
          console.log("New session: ", sessionData);
          return sessionData; // Return data for potential use in component
        } catch (error) {
          console.error("Login failed in store:", error);
          set({ session: null }); // Clear session on error
          throw error; // Re-throw error to be caught by the component
        }
      },

      // Simple logout action
      logout: () => {
        set({ session: null, snacks: [] });
      },

      addSnack: (snack) => {
        set((state) => {
          console.log("Current snacks:", state.snacks);
          console.log("Adding snack:", snack);
          // Ensure snacks is always an array
          const currentSnacks = Array.isArray(state.snacks) ? state.snacks : [];
          return { snacks: [...currentSnacks, snack] };
        });
      },

      removeSnack: (id) => {
        set((state) => ({
          // Ensure snacks is always an array before filtering
          snacks: (Array.isArray(state.snacks) ? state.snacks : []).filter(snack => snack.id !== id)
        }));
      },
    }),
    {
      name: 'fridge-storage', // localStorage key name
    }
  )
);
