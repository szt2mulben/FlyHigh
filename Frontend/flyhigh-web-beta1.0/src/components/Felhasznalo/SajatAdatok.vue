<template> 
    <h1>Személyes adataim:</h1>
    <div class="gep-container">
      <div v-for="user in sajatadat" class="gep-card">
        <div class="info">
          <p><span>Név:</span> {{user.name}}</p>
          <p><span>Jelszó:</span> ********</p>
          <p><span>Email:</span> {{user.email}}</p>
          <p><span>Jogosultság:</span> {{user.permission}}</p>
        </div>
      </div>
    </div> 
    <h2>Jegyek:</h2>   
  </template>
  <script setup>
  import axios from 'axios';
  import { onMounted, ref } from 'vue';
  import { parseToken, getUsername } from '../../utils/auth.js';

const token = localStorage.getItem('token');
const payload = parseToken(token);

const user = getUsername(payload);
const sajatadat = ref([]);

  onMounted(() => {
    axios.get('https://localhost:7151/api/Useradatok')
    .then(resp => {
        for (let i = 0; i < resp.data.length; i++) {
            if (user == resp.data[i].name) {
                sajatadat.value.push(resp.data[i]);            
            }else continue;      
        }
    });
  });



  
  </script>
  
  <style scoped>
  .gep-container {
    display: flex;
    flex-wrap: wrap;
  }
  
  .gep-card {
    margin: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    width: 200px;
  }
  
  .info {
    padding: 10px;
    background-color: #f0f0f0;
    border-bottom: 1px solid #ccc;
  }
  
  .info p {
    margin: 20px 0;
    font-weight: bold;
  }
  
  </style>