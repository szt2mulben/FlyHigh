<template> 
    <h1>Személyes adataim:</h1>
    <div class="gep-container">
      <div v-for="user in sajatadat" class="gep-card">
        <div class="info">
          <p><span>Név:</span> {{user.name}}</p>
          <p><span>Jelszó:</span> ********</p>
          <p><span>Email:</span> {{user.email}}</p>
        </div>
      </div>
    </div> 
    <h2>Repjegy(ek):</h2>
    <div class="search-results">
      <div class="flight-card" v-for="(flight, index) in jegyek" :key="index">
        <div class="left" style="margin: 5px; padding: 10px; ">
          <div>Honnan: {{ flight.indulas_hely }}</div>
          <div>Indulás ideje: {{ flight.indulasido }}</div>
          <div>Utasok száma: {{ flight.utazok }}</div>
          <div>Osztály: {{ flight.osztaly }}</div>
        </div>
        <div class="right"style="margin: 5px; padding: 10px;">
          <div>Hova: {{ flight.erkezes_hely }}</div>
          <div>Érkezés ideje: {{ flight.erkezesido }}</div>
          <div>Ár: {{ flight.ar }} Ft</div>
        </div>
      </div>
    </div>
  </template>
  <script setup>
  import axios from 'axios';
  import { onMounted, ref } from 'vue';
  import { parseToken, getUsername, getPermissions } from '../../utils/auth.js';

const token = localStorage.getItem('token');
const payload = parseToken(token);

const user = getUsername(payload);
const sajatadat = ref([]);
const jegyek = ref([]);


  onMounted(() => {
    axios.get('https://localhost:7151/api/Useradatok')
    .then(resp => {
        for (let i = 0; i < resp.data.length; i++) {
            if (user == resp.data[i].name) {
                sajatadat.value.push(resp.data[i]);            
            }else continue;      
        }
    });
    axios.get('https://localhost:7151/api/Jegykezeles')
    .then(resp => {
      jegyek.value = resp.data.filter(ticket => ticket.megrendelo_nev === user);
    })
    .catch(error => {
      console.error('Error fetching countries:', error);
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
  .flight-card .left, .flight-card .right {
  flex: 1;
}

.flight-card .right {
  text-align: right;
}
.flight-card {
  display: flex;
  margin-bottom: 10px;
  padding: 10px;
  border: 1px solid #ccc;
}
.search-results {
  margin-top: 20px;
}

  
  </style>