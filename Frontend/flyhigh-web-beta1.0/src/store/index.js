import { createStore } from 'vuex'

export default createStore({
  state() {
    return {
      isLoggedIn: false
    }
  },
  mutations: {
    login(state) {
      state.isLoggedIn = true
    },
    logout(state) {
      state.isLoggedIn = false
    }
  },
  actions: {
    // További akciók
  },
  modules: {
    // További modulok
  }
})
