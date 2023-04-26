import {
	FETCH_ACCOUNTS_SUCCEED,
	FETCH_ACCOUNTS_FAILED,
	FETCH_ACCOUNT_SUCCEED,
	FETCH_ACCOUNT_FAILED,
	CREATE_ACCOUNT_SUCCEED,
	CREATE_ACCOUNT_FAILED,
	UPDATE_ACCOUNT_SUCCEED,
	UPDATE_ACCOUNT_FAILED,
	DELETE_ACCOUNT_SUCCEED,
	DELETE_ACCOUNT_FAILED,
	CHECK_SECURED_KEY_SUCCEED,
	CHECK_SECURED_KEY_FAILED,
} from "@/redux/Constant/payment/userAccount";
import userAccountService from "@/redux/Services/payment/userAccount";
import { put, call } from "redux-saga/effects";

export function* fetchUserAccounts(): any {
	const result = yield call(userAccountService.getAll);
	try {
		yield put({
			type: FETCH_ACCOUNTS_SUCCEED,
			data: result.data,
		});
	} catch (error) {
		yield put({
			type: FETCH_ACCOUNTS_FAILED,
			error: error,
		});
	}
}

export function* fetchUserAccountBy(action: any): any {
	const result = yield call(userAccountService.getbyUser, action.data);
	try {
		yield put({
			type: FETCH_ACCOUNT_SUCCEED,
			data: result.data,
		});
	} catch (error) {
		yield put({
			type: FETCH_ACCOUNT_FAILED,
			error: error,
		});
	}
}

export function* createUserAccount(action: any): any {
	const result = yield call(userAccountService.insert, action.data);
	try {
		yield put({
			type: CREATE_ACCOUNT_SUCCEED,
			data: result.data,
		});
	} catch (error) {
		yield put({
			type: CREATE_ACCOUNT_FAILED,
			error: error,
		});
	}
}

export function* updateUserAccount(action: any): any {
	const result = yield call(userAccountService.update, action.data);
	try {
		yield put({
			type: UPDATE_ACCOUNT_SUCCEED,
			data: action.data,
		});
	} catch (error) {
		yield put({
			type: UPDATE_ACCOUNT_FAILED,
			error: error,
		});
	}
}

export function* deleteUserAccount(action: any): any {
	const result = yield call(userAccountService.remove, action.data);
	try {
		yield put({
			type: DELETE_ACCOUNT_SUCCEED,
			data: action.data,
		});
	} catch (error) {
		yield put({
			type: DELETE_ACCOUNT_FAILED,
			error: error,
		});
	}
}

export function* checkSecuredKey(action: any): any {
	const result = yield call(userAccountService.check, action.data);
	try {
		yield put({
			type: CHECK_SECURED_KEY_SUCCEED,
			result: result.data.response.result,
			message: result.data.message,
		});
	} catch (error) {
		yield put({
			type: CHECK_SECURED_KEY_FAILED,
			result: result.data.response.result,
			error: error,
			message: result.data.message,
		});
	}
}
