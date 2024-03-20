import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import LoginRegister from '../components/Login.vue';
import AboutView from '../views/AboutView.vue'


const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'About',
      component: AboutView
    },
    {
      path: '/home',
      name: 'home',
      component: HomeView,
    },
    {
      path: '/loginregister',
      name: 'loginregister',
      component: LoginRegister,
    },
    {
      path: '/about',
      name: 'about',
      component: () => import('../views/AboutView.vue')
    },
    {
      path: '/ujgep',
      name: 'ujgep',
      component: () => import('../views/Ujgepadatok.vue')
    }
  ]
});
 


export default router
