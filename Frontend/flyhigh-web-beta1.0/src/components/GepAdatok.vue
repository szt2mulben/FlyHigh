<template> 
  <h1>Gépek Adatai:</h1>
  <div class="search-container">
    <p>Keresési kritérium:(Gép neve)</p>
    <input type="text" v-model="kereses" @input="keresesValtozas()" placeholder="Keresés..." id="teszt">
  </div>
  <div class="gep-container">
    <div v-for="gepek in megjelenitettGepadatok" :key="gepek.id" class="gep-card">
      <div class="info">
        <p><span>Gép neve:</span> {{gepek.gepneve}}</p>
        <p><span>Foglalt turista:</span> {{gepek.foglaltturista}}</p>
        <p><span>Foglalt elsőosztály:</span> {{gepek.foglalt1oszt}}</p>
        <p><span>ELsőosztály ulohelyek:</span> {{gepek.elsoosztulohelyek}}</p>
        <p><span>Turistaulohelyek:</span> {{gepek.turistaulohelyek}}</p>
      </div>
    </div>
  </div>
</template>

<script setup>
import axios from 'axios';
import { onMounted, ref } from 'vue';

const gepadatok = ref([]);
const kereses = ref('');
const megjelenitettGepadatok = ref([]);


onMounted(() => {
  axios.get('https://localhost:7151/api/Gepadatok')
  .then(resp => {
      gepadatok.value = resp.data;
      megjelenitettGepadatok.value = resp.data;
  });
});


const keresesValtozas = async () => {
if(teszt.value != "")
{
  try {
    const response = await axios.get(`https://localhost:7151/api/Gepadatok/search/${kereses.value}`);
    megjelenitettGepadatok.value = response.data;
  } catch (error) {
    console.error('Hiba történt a gépadatok keresése közben:', error);
  }
}else{ alert("Ne hagy üresen a mezőt.")} s
};
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
  margin: 5px 0;
  font-weight: bold;
}

.search-container {
  margin-bottom: 20px;
}
</style>
