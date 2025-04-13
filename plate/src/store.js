
import { create } from 'zustand';

export const useStore = create((set) => ({
  snacks: [],

  addSnack: (snack) => {
    set((state) => ({ snacks: [...state.snacks, snack] }));
  },
}));

