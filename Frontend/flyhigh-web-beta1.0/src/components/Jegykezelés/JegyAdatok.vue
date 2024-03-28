<template>
  <div class="flight-search">
    <div v-if="!bookingCompleted">
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
            <option value="economy">Economy</option>
            <option value="business">Business</option>
          </select>
        </div>
      </div>
      <button @click="searchFlights">Repülőjegyek keresése</button>
    </div>
    <div v-if="searchResults.length > 0 ">
      <h2 v-if="!bookingCompleted">Repülőjegyek</h2>
      <h2 v-if="bookingCompleted">Adatok:</h2>
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
            <button @click="reserveTicket(flight)" v-if="!bookingCompleted">Foglalás</button>
          </div>
        </div>
      </div>
    </div>
    <div v-if="bookingCompleted">
      <h2>Utas adatok</h2>
      <div class="passenger-info">
        <div v-for="(passenger, index) in passengerCount" :key="index">
          <h3>{{ index + 1 }} utas adatai:</h3>
          <div class="field">
            <select>
              <option value="male">Férfi</option>
              <option value="female">Nő</option>
            </select>
          </div>
          <div class="field">
            <input type="text" placeholder="Vezetéknév">
          </div>
          <div class="field">
            <input type="text" placeholder="Keresztnév">
          </div>
          <div class="field">
            <input type="date" placeholder="Születési dátum:">
          </div>
        </div>
      </div>
      <h2>Számlázási adatok</h2>
      <div class="billing-info">
        <div class="field">
          <input type="text" id="billingName" placeholder="Számlázási név">
        </div>
        <div class="field">
          <select id="billingCountry">
            <option value="Hungary">Magyarország</option>
            <option value="Hungary">Románia</option>
            <option value="Hungary">Bulgária</option>
            <option value="Hungary">Csehország</option>
            <option value="Hungary">Ausztria</option>
          </select>
        </div>
        <div class="field">
          <input type="number" id="billingZip" placeholder="Irányítószám">
        </div>
        <div class="field">
          <input type="text" id="billingCity" placeholder="Település">
        </div>
        <div class="field">
          <input type="text" id="billingAddress" placeholder="Cím">
        </div>
      </div>
      <h2>Fizetési mód</h2>
      <div class="payment-method">
        <h3 class="payment-heading"><input type="checkbox">Bankkártyás fizetés</h3>
        <div class="payment-details">
          <p class="payment-info">A foglalás véglegesítésével egy biztonságos kártyaelfogadó oldalra irányítjuk, ahol a kártyaadatok megadásával egyszerűen kifizetheti repülőjegyét. Minden további teendőről és részletes információról, a fizetést követő visszaigazoló emailben tájékozódhat.</p>
          <p class="payment-info">Kérjük ne felejtse el megerősíteni fizetését mobileszközén! (3DS Authentication)</p>
          <p class="payment-info">Figyelem: a sikeres fizetéssel a repülőjegy automatikusan kiállításra kerül és ezt követően már csak a légitársaság szabályainak megfelelően módosítható!</p>
        </div>
      </div>
      <h2>Ülőhely-választó</h2>
      <div>
        <p>Foglalja le az Önnek megfelelő helyet a repülőgépen, így elkerülheti a légitársaság automatikus helyválasztását!</p>
        <button @click="toggleSeatSelector">Ülőhely kiválasztás</button>
      </div>
      <transition name="slide">
        <div class="plane-seats" v-if="showSeatSelector">
          <div class="left-column">
            <div class="column" v-for="row in 2" :key="row">
              <div class="row" v-for="column in 2" :key="column">
                <div class="seat" v-for="seatNumber in 30" :key="(row - 1) * 30 + seatNumber" @click="selectSeat(row, seatNumber, column)">
                  {{ getSeatLabel(row, seatNumber, column) }}
                </div>
              </div>
            </div>
          </div>
          <div class="empty-column"></div>
          <div class="right-column">
            <div class="column" v-for="row in 2" :key="row">
              <div class="row" v-for="column in 2" :key="column">
                <div class="seat" v-for="seatNumber in 30" :key="(3 + column - 1) * 30 + seatNumber" @click="selectSeat(row, seatNumber, 3 + column)">
                  {{ getSeatLabel(row, seatNumber, 3 + column) }}
                </div>
              </div>
            </div>
          </div>
        </div>
      </transition>
    </div>
  </div>
</template>

<script setup>
import axios from 'axios';
import { ref, onMounted } from 'vue';
import { parseToken, getUsername } from '../../utils/auth.js';

const token = localStorage.getItem('token');
const payload = parseToken(token);
const user = getUsername(payload);

const from = ref('');
const to = ref('');
const departureTime = ref('');
const passengerCount = ref('');
const flightClass = ref('');
const countries = ref([]);
const searchResults = ref([]);
const bookingCompleted = ref(false);
const showSeatSelector = ref(false);

const toggleSeatSelector = () => {
  showSeatSelector.value = !showSeatSelector.value;
};

onMounted(() => {
  axios.get('https://localhost:7151/api/Orszagok')
    .then(resp => {
      countries.value = resp.data;
    })
    .catch(error => {
      console.error('Error fetching countries:', error);
    });
});

const generateRandomPrice = () => {
  return Math.floor(Math.random() * 10000) + 15000;
};

const searchFlights = async () => {
  try {
    const seged = ref([]);
    const response = await axios.get(`https://localhost:7151/api/JegyAdatok/search`, {
      params: {
          honnan: from.value,
          hova: to.value
      },
    });
    seged.value = response.data;
    if (!response.data || response.data.length === 0) {
      console.log('Nincs ilyen járat.');
      return;
    } else {
      let prevId = 0; 
      const flights = response.data.map(flight => {
        const id = prevId + 1; 
        prevId = id; 
        return {
          id,
          user : user,
          from: from.value,
          to: to.value,
          time : seged.value[id-1].ido,
          departure: `${seged.value[id-1].ora}:${seged.value[id-1].perc}` ,
          arrival: `${(seged.value[id-1].ora)+2}:${seged.value[id-1].perc}`,
          class : flightClass.value,
          passenger : passengerCount.value,
          price: generateRandomPrice()
        };
      });
      searchResults.value = flights;
    }
  } catch (error) {
    console.error('Hiba az adatok lekérdezésében:', error);
  }
};

const reserveTicket = async (flight) => {
  try {
    searchResults.value = [];
    searchResults.value.push(flight);
    bookingCompleted.value = true;
  } catch (error) {
    console.error('Hiba a jegy foglalásában:', error);
  }
};

// Új függvények a székek kezeléséhez
const selectedSeats = ref([]);
const selectedSeatsData = ref([]);

const selectSeat = (row, seatNumber, column) => {
  const seatIndex = (row - 1) * 30 + (column - 1) * 30 + seatNumber;
  if (!selectedSeats.value.includes(seatIndex)) {
    selectedSeats.value.push(seatIndex);
    selectedSeatsData.value.push({
      row,
      seatNumber,
      column,
    });
  } else {
    const index = selectedSeats.value.indexOf(seatIndex);
    if (index > -1) {
      selectedSeats.value.splice(index, 1);
      selectedSeatsData.value.splice(index, 1);
    }
  }
  saveSelectedSeatsData();
};

const getSeatLabel = (row, seatNumber, column) => {
  const seatIndex = (row - 1) * 30 + (column - 1) * 30 + seatNumber;

  return `${seatIndex}`;
};

const saveSelectedSeatsData = () => {
  console.log(selectedSeatsData.value);
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
.payment-method {
  border: 1px solid #ccc;
  border-radius: 5px;
  padding: 10px;
  margin-top: 20px;
}

.payment-method h3 {
  font-size: 24px;
  margin-bottom: 10px;
}

.payment-content p {
  font-size: 14px;
  line-height: 1.5;
  margin-bottom: 10px;
}
.slide-enter-active, .slide-leave-active {
  transition: transform 0.5s ease;
}
.slide-enter, .slide-leave-to {
  transform: translateX(0);
}
.slide-enter-to, .slide-leave {
  transform: translateX(100%);
}

.seat-selector {
  position: fixed;
  top: 0;
  right: 0;
  width: 700px;
  height: 100%;
  background-color: #f0e9e9;
  box-shadow: -2px 0 5px rgba(0, 0, 0, 0.1);
  z-index: 1000; 
  padding: 20px;
}

.close-btn {
  position: absolute;
  top: 10px;
  right: 10px;
  padding: 5px 10px;
  background-color: #007bff;
  color: #fff;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

.plane-seats {
  display: flex;
}

.left-column,
.right-column {
  flex: 1;
}

.empty-column {
  width: 40px; /* Üres oszlop szélessége */
}

.column {
  display: flex;
  flex-direction: column;
}

.row {
  display: flex;
  flex-wrap: wrap;
}

.seat {
  width: 40px;
  height: 40px;
  margin: 5px;
  border: 1px solid #ccc;
  display: flex;
  justify-content: center;
  align-items: center;
}

</style>
