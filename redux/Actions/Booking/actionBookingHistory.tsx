import ActionTypes from "@/redux/Constant/Booking/actionType"

export const orderDetailHistoryRequest=(payload:any)=>{
    return {
        type: ActionTypes.GET_HISTORY_BOOKING,
        payload
    }
}

export const orderDetailHistoryRequestSecced=(payload:any)=>{
    return {
        type: ActionTypes.GET_HISTORY_BOOKING_SUCCED,
        payload
    }
}

export const orderDetailHistoryRequestFailed=(payload:any)=>{
    return {
        type: ActionTypes.GET_HISTORY_BOOKING_FAILED,
        payload
    }
}
