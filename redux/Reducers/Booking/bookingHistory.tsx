import ActionTypes from "../../Constant/Booking/actionType"

const initialState ={
    booking_history:[]
};

function bookingHistoryReducer(state = initialState, action:any):any{
    switch (action.type){
        case ActionTypes.GET_HISTORY_BOOKING:
            return{...state};
        case ActionTypes.GET_HISTORY_BOOKING_SUCCED:
            return {...state, booking_history:action.payload};
        case ActionTypes.GET_HISTORY_BOOKING_FAILED:
            return {...state, booking_history:action.payload};
        default:
            return{...state}
        }
    }
    
export default bookingHistoryReducer;