<template>
  <div class="flight-search">
    <h2>Repülőjegy keresés</h2>
    <div class="search-fields">
      <div class="field">
        <label for="from">Honnan:</label>
        <select id="from" v-model="from">
          <option v-for="country in countries" :value="country.orszag_nev">{{ country.orszag_nev }}</option>
        </select>
      </div>
      <div class="field">
        <label for="to">Hova:</label>
        <select id="to" v-model="to">
          <option v-for="country in countries" :value="country.orszag_nev">{{ country.orszag_nev }}</option>
        </select>
      </div>
      <div class="field">
        <label for="departure">Indulás ideje:</label>
        <input type="date" id="departure" v-model="departureTime">
      </div>
      <div class="field">
        <label for="passengers">Utasok száma:</label>
        <input type="number" id="passengers" v-model="passengerCount">
      </div>
      <div class="field">
        <label for="class">Osztály:</label>
        <select id="class" v-model="flightClass">
          <option value="">Economy</option>
          <option value="">Business</option>
        </select>
      </div>
    </div>
    <button @click="searchFlights">Repülőjegyek keresése</button>
  </div>
    <div class="search-results">
      <div class="flight-card" v-for="(flight, index) in searchResults" :key="index">
        <div class="left">
          <div>Honnan: {{ flight.from }}</div>
          <div>Indulás ideje: {{ flight.departure }}</div>
        </div>
        <div class="right">
          <div>Hova: {{ flight.to }}</div>
          <div>Érkezés ideje: {{ flight.arrival }}</div>
          <div>Ár: {{ flight.price }} Ft</div>
          <button @click="reserveTicket(flight)">Foglalás</button>
        </div>
      </div>
    </div>
</template>

<script setup>
import axios from 'axios';
import { onMounted, ref } from 'vue';

const from = ref('');
const to = ref('');
const departureTime = ref('');
const passengerCount = ref('');
const flightClass = ref('');
const countries = ref([]);
const searchResults = ref([]);

onMounted(() => {
  axios.get('https://localhost:7151/api/Orszagok')
    .then(resp => {
      countries.value = resp.data;
    })
    .catch(error => {
      console.error('Error fetching countries:', error);
    });
});

const generateRandomTime = () => {
  const hours = String(Math.floor(Math.random() * 24)).padStart(2, '0');
  const minutes = String(Math.floor(Math.random() * 60)).padStart(2, '0');
  return `${hours}:${minutes}`;
};

const generateRandomPrice = () => {
  return Math.floor(Math.random() * 10000) + 15000;
};

const seged = {
  honnan: from.value,
  hova: to.value,
  ido : departureTime.time
};

const searchFlights = async () => {
  try {
const response = await axios.post(`https://localhost:7151/api/JegyAdatok/search`, {
      'honnan': seged.honnan,
      'hova': seged.hova,
    });  

    if (!response.data || response.data.length === 0) {
      console.log('Nincs ilyen járat.');
      return;
    }else{

    const limitedData = response.data.slice(0, 5); 
    let prevId = 0; 

    const flights = limitedData.map(flight => {
      const id = prevId + 1; 
      prevId = id; 

      return {
        id,
        from: from.value,
        to: to.value,
        departure: generateRandomTime(),
        arrival: generateRandomTime(),
        price: generateRandomPrice()
      };
    });

    searchResults.value = flights;
  }
  } catch (error) {
    console.error('Error fetching flight data:', error);
  }
};
const reserveTicket = (flight) => {
  alert('Foglalás gombra kattintva. Repülőjegy: ' + JSON.stringify(flight));
};
</script>

<style scoped>
.flight-search {
  max-width: 400px;
  margin: 0 auto;
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 5px;
}

.search-fields {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.field label {
  font-weight: bold;
}

.field input, .field select {
  width: 100%;
  padding: 8px;
  border-radius: 5px;
  border: 1px solid #ccc;
}

button {
  margin-top: 10px;
  padding: 8px 16px;
  background-color: #007bff;
  color: #fff;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

.search-results {
  margin-top: 20px;
}

.flight-card {
  display: flex;
  margin-bottom: 10px;
  padding: 10px;
  border: 1px solid #ccc;
}

.flight-card .left, .flight-card .right {
  flex: 1;
}

.flight-card .right {
  text-align: right;
}
</style>
