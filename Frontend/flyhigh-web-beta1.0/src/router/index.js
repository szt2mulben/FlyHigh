import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import LoginRegister from '../components/Login.vue';

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'LoginRegister',
      component: LoginRegister
    },
    {
      path: '/home',
      name: 'home',
      component: HomeView,
      meta: { requiresAuth: true }
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
 
router.beforeEach((to, from, next) => {
  if (to.matched.some(record => record.meta.requiresAuth)) {
    if (!isLoggedIn()) {
      next({ name: 'LoginRegister' });
    } else {
      next();
    }
  } else {
    next();
  }
});

export default router
