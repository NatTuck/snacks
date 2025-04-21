
import { create } from 'zustand';

export const useStore = create((set) => ({
  session: null,
  snacks: [],

  setSession: (session) => {
    set({ session: session });
  },

  addSnack: (snack) => {
    set((state) => ({ snacks: [...state.snacks, snack] }));
  },
}));

