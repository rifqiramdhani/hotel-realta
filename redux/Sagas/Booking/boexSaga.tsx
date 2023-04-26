import { call, put } from "@redux-saga/core/effects";
import ApiOrderDetails from "@/redux/Services/Booking/apiOrderDetails";
import { boexCreateFailed, boexCreateSucced } from "@/redux/Actions/Booking/actionBoex";

function * handleAddBoex(action:any):any{
    try{
        const result = yield call(ApiOrderDetails.createBoex,action.payload)
        console.log(result.data);
        yield put(boexCreateSucced(result.data))
    }catch(error:any){
        yield put(boexCreateFailed(error))
    }
}

export {handleAddBoex};