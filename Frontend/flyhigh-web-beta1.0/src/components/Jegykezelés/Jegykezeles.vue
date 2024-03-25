<template>
    <div class="flight-search">
      <h2>Repülőjegy keresés</h2>
      <div class="search-fields">
        <div class="field">
          <label for="from">Honnan:</label>
          <select id="from" v-model="from">
            <option v-for="country in countries" :value="country.code">{{ country.name }}</option>
          </select>
        </div>
        <div class="field">
          <label for="to">Hova:</label>
          <select id="to" v-model="to">
            <option v-for="country in countries" :value="country.code">{{ country.name }}</option>
          </select>
        </div>
        <div class="field">
          <label for="departure">Indulás ideje:</label>
          <input type="datetime-local" id="departure" v-model="departureTime">
        </div>
        <div class="field">
          <label for="passengers">Utasok száma:</label>
          <input type="number" id="passengers" v-model="passengerCount">
        </div>
        <div class="field">
          <label for="class">Osztály:</label>
          <select id="class" v-model="flightClass">
            <option value="economy">Economy</option>
            <option value="business">Business</option>
          </select>
        </div>
      </div>
      <button @click="searchFlights">Repülőjegyek keresése</button>
    </div>
  </template>
  
  <script>
  import axios from 'axios';
  
  export default {
    data() {
      return {
        from: '',
        to: '',
        departureTime: '',
        passengerCount: 1,
        flightClass: 'economy',
        countries: []
      };
    },
    mounted() {
      this.fetchCountries();
    },
    methods: {
      async fetchCountries() {
        try {
          const response = await axios.get('https://localhost:7151/api/Orszagok');
          this.countries = response.data;
        } catch (error) {
          console.error('Hiba történt az országok lekérdezésekor:', error);
        }
      },
      searchFlights() {
        console.log('Keresési paraméterek:', {
          from: this.from,
          to: this.to,
          departureTime: this.departureTime,
          passengerCount: this.passengerCount,
          flightClass: this.flightClass
        });
      }
    }
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
  </style>
  