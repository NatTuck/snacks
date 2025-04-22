
import { create } from 'zustand';
import { persist } from 'zustand/middleware';

export const useStore = create(
  persist(
    (set) => ({
      session: null,
      snacks: [],

      setSession: (session) => {
        set({ session: session });
      },

      addSnack: (snack) => {
        set((state) => {
          console.log("Current snacks:", state.snacks);
          console.log("Adding snack:", snack);
          return { snacks: [...state.snacks, snack] };
        });
      },
      
      removeSnack: (id) => {
        set((state) => ({ 
          snacks: state.snacks.filter(snack => snack.id !== id) 
        }));
      },
    }),
    {
      name: 'fridge-storage',
    }
  )
);

