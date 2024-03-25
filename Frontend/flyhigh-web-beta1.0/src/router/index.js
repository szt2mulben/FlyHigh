import { createRouter, createWebHistory } from 'vue-router'
import { parseToken, getUsername, getPermissions } from '../utils/auth.js';
import { ref } from 'vue';
import GepAdatokView from '../views/GepAdatokView.vue'
import LoginRegister from '../components/LoginRegister/Login.vue';
import KezdolapView from '../views/KezdolapView.vue'



const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'kezdolap',
      component: KezdolapView,
      meta: { requiresAuth: true, roles: ['Admin', 'Ugyfel'] } 
    },
    {
      path: '/felhasznaloiadatok',
      name: 'felhasznaloadat',
      component: () => import('../views/FelhasznaloiAdatokView.vue'),
      meta: { requiresAuth: true , roles: ['Admin']}
    },
    {
      path: '/sajatadatok',
      name: 'sajatadatok',
      component: () => import('../views/SajatAdatokView.vue'),
      meta: { requiresAuth: true , roles: ['Admin', 'Ugyfel']}
    },
    {
      path: '/jegyek',
      name: 'jegyek',
      component: () => import('../views/JegykezelesView.vue'),
      meta: { requiresAuth: true , roles: ['Admin', 'Ugyfel']}
    },
    {
      path: '/gepadatok',
      name: 'gepadatok',
      component: GepAdatokView,
      meta: { requiresAuth: true, roles: ['Admin', 'Ugyfel'] } 

    },
    {
      path: '/loginregister',
      name: 'loginregister',
      component: LoginRegister,
      meta: { requiresAuth: false }
    },
    {
      path: '/ujgep',
      name: 'ujgep',
      component: () => import('../views/Ujgepadatok.vue'),
      meta: { requiresAuth: true, roles: ['Admin'] } 

    }
  ]
});
 
function checkAuth() {
  const token = localStorage.getItem('token');
  return token !== null;
}


router.beforeEach((to, from, next) => {
  const isAuthenticated = checkAuth();
  const requiresAuth = to.matched.some(record => record.meta.requiresAuth);
  const token = localStorage.getItem('token');
  const payload = parseToken(token);
  const userRole = getPermissions(payload);

  if (requiresAuth && !isAuthenticated) {
    next({ name: 'loginregister' });
  } else if (requiresAuth && isAuthenticated) {
    if (to.meta.roles && to.meta.roles.includes(userRole)) { 
      next();
    } else {
      next({ name: 'Unauthorized' }); 
    }
  } else {
    next();
  }
});


export default router
