import NProgress from 'nprogress'

import * as types from '@/stores/mutation-types'
import FarmApi from '@/stores/api/farm'
import stubFarm from '@/stores/stubs/farm'
import stubReservoir from '@/stores/stubs/reservoir'
import stubCrop from '@/stores/stubs/crop'
import stub from '@/stores/stubs/farm'

const state = {
  farm: stub,
  farms: [],
  reservoir: {},
  reservoirs: [],
  area: {},
  areas: [],
  types: [],
  inventories: [],
  crops: [],
  cropnotes: [],
}

const getters = {
  getCurrentFarm: state => state.farm,
  getCurrentReservoir: state => state.reservoir,
  getCurrentArea: state => state.area,
  getAllFarms: state => state.farms,
  getAllReservoirs: state => state.reservoirs,
  getAllAreas: state => state.areas,
  getAllFarmTypes: state => state.types,
  getAllFarmInventories: state => state.inventories,
  getAllCrops: state => state.crops,
  haveFarms: state => state.farms.length > 0 ? true : false
}

const actions = {
  createFarm ({ commit, state }, payload) {
    NProgress.start()
    return new Promise((resolve, reject) => {
      FarmApi
        .ApiCreateFarm(payload, ({ data }) => {
          commit(types.CREATE_FARM, data.data)
          commit(types.SET_FARM, data.data)
          resolve(data.data)
        }, error => reject(error.response))
    })
  },
  fetchFarmTypes ({ commit, state }) {
    NProgress.start()
    return new Promise((resolve, reject) => {
      FarmApi
        .ApiGetFarmTypes(({ data }) => {
          commit(types.FETCH_FARM_TYPES, data)
          resolve(data)
        }, error => reject(error.response))
    })
  },
  fetchFarmInventories ({ commit, state }) {
    NProgress.start()
    return new Promise((resolve, reject) => {
      FarmApi
        .ApiFetchFarmInventories(({ data }) => {
          commit(types.FETCH_FARM_INVENTORIES, data.data)
          resolve(data)
        }, error => reject(error.response))
    })
  },
  setCurrentFarm({ commit, state }, farmId) {
    return new Promise((resolve, reject) => {
      let farm = state.farms.find(item => item.uid === farmId)
      if (farm) {
        commit(types.SET_FARM, farm)
        resolve(farm)
      } else {
        reject()
      }
    }, error => reject(error))
  },
  createReservoir ({ commit, state }, payload) {
    NProgress.start()
    return new Promise((resolve, reject) => {
      const farmId = state.farm.uid
      FarmApi
        .ApiCreateReservoir(farmId, payload, ({ data }) => {
          payload = data.data
          payload.farm_id = farmId
          commit(types.CREATE_RESERVOIR, payload)
          resolve(payload)
        }, error => reject(error.response))
    })
  },
  fetchReservoirs ({ commit, state }, payload) {
    NProgress.start()
    return new Promise((resolve, reject) => {
      const farmId = state.farm.uid
      FarmApi.ApiFetchReservoir(farmId, ({ data }) => {
        commit(types.FETCH_RESERVOIR, data.data)
        resolve(data)
      }, error => reject(error.response))
    })
  },
  createArea ({ commit, state }, payload) {
    NProgress.start()
    return new Promise((resolve, reject) => {
      const formData = new FormData()
      formData.set('name', payload.name)
      formData.set('size', payload.size)
      formData.set('size_unit', payload.size_unit)
      formData.set('type', payload.type)
      formData.set('location', payload.location)
      formData.set('reservoir_id', payload.reservoir_id)
      formData.set('photo', payload.photo)
      formData.set('farm_id', state.farm.uid)

      FarmApi.ApiCreateArea(state.farm.uid, formData, ({ data }) => {
        commit(types.CREATE_AREA, {
          ...data.data,
          photo: '/api/farms/' + state.farm.uid + '/areas/' + data.data.uid + '/photos'
        })
        resolve(payload)
      }, error => reject(error.response))
    })
  },
  fetchAreas ({ commit, state }, payload) {
    NProgress.start()
    return new Promise((resolve, reject) => {
      const farmId = state.farm.uid
      FarmApi.ApiFetchArea(farmId, ({ data }) => {
        commit(types.FETCH_AREA, data.data)
        resolve(data)
      }, error => reject(error.response))
    })
  },
  getAreaByUid ({ commit, state }, areaId) {
    NProgress.start()
    return new Promise((resolve, reject) => {
      const farmId = state.farm.uid
      FarmApi.ApiFindAreaByUid(farmId, areaId, ({ data }) => {
        resolve(data)
      }, error => reject(error.response))
    })
  },
  createCrop ({ commit, state }, payload) {
    NProgress.start()
    return new Promise((resolve, reject) => {
      const farmId = state.farm.uid
      let areaId = payload.initial_area
      FarmApi
        .ApiCreateCrop(areaId, payload, ({ data }) => {
          payload = data.data
          payload.farm_id = farmId
          commit(types.CREATE_CROP, payload)
          resolve(payload)
        }, error => reject(error.response))
    })
  },
  fetchCrops ({ commit, state }, payload) {
    NProgress.start()
    return new Promise((resolve, reject) => {
      const farmId = state.farm.uid
      FarmApi.ApiFetchCrop(farmId, ({ data }) => {
        commit(types.FETCH_CROP, data.data)
        resolve(data)
      }, error => reject(error.response))
    })
  },
  getCropByUid ({ commit, state }, cropId) {
    NProgress.start()
    return new Promise((resolve, reject) => {
      const farmId = state.farm.uid
      FarmApi.ApiFindCropByUid(farmId, cropId, ({ data }) => {
        resolve(data)
      }, error => reject(error.response))
    })
  },
  createCropNotes ({ commit, state }, payload) {
    NProgress.start()
    return new Promise((resolve, reject) => {
      let cropId = payload.obj_uid
      FarmApi
        .ApiCreateCropNotes(cropId, payload, ({ data }) => {
          payload = data.data
          commit(types.CREATE_CROP_NOTES, payload)
          resolve(payload)
        }, error => reject(error.response))
    })
  },
}

const mutations = {
  [types.FETCH_FARM_TYPES] (state, payload) {
    state.types = payload
  },
  [types.FETCH_FARM_INVENTORIES] (state, payload) {
    state.inventories = payload
  },
  [types.CREATE_FARM] (state, payload) {
    state.farms.push(payload)
  },
  [types.SET_FARM] (state, payload) {
    state.farm = payload
  },
  [types.CREATE_RESERVOIR] (state, payload) {
    state.reservoirs.push(payload)
  },
  [types.SET_RESERVOIR] (state, payload) {
    state.reservoir = payload
  },
  [types.FETCH_RESERVOIR] (state, payload) {
    state.reservoirs = payload
  },
  [types.CREATE_AREA] (state, payload) {
    state.areas.push(payload)
  },
  [types.SET_AREA] (state, payload) {
    state.area = payload
  },
  [types.FETCH_AREA] (state, payload) {
    state.areas = payload
  },
  [types.CREATE_CROP] (state, payload) {
    state.crops.push(payload)
  },
  [types.SET_CROP] (state, payload) {
    state.crops = payload
  },
  [types.FETCH_CROP] (state, payload) {
    state.crops = payload
  },
  [types.CREATE_CROP_NOTES] (state, payload) {
    state.cropnotes.push(payload)
  },
}

export default {
  state, getters, actions, mutations
}
