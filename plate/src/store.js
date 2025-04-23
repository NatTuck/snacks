import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { loginUser } from './api'; // Import the API function

export const useStore = create(
  persist(
    (set) => ({
      session: null, // Will store { user: object, token: string } or null
      snacks: [],    // Will store snacks list from login or subsequent actions

      // New async login action
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

      // Simple logout action - clear session and snacks
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
      // By default, persist saves the entire store state (session and snacks)
      // If you only wanted to persist the session, you could customize it:
      // partialize: (state) => ({ session: state.session }),
    }
  )
);
