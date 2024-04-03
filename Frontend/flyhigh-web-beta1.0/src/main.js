//import './assets/main.css'
import '../src/style.css'
import AOS from "aos";
import "aos/dist/aos.css"

import { createApp } from 'vue'
import { createPinia } from 'pinia'

import App from './App.vue'
import router from './router'

AOS.init();
const app = createApp(App)

app.use(createPinia())
app.use(router)

app.mount('#app')
