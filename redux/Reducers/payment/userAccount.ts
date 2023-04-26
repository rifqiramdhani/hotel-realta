import {
	FETCH_ACCOUNTS,
	FETCH_ACCOUNTS_FAILED,
	FETCH_ACCOUNTS_SUCCEED,
	FETCH_ACCOUNT,
	FETCH_ACCOUNT_FAILED,
	FETCH_ACCOUNT_SUCCEED,
	CREATE_ACCOUNT,
	CREATE_ACCOUNT_FAILED,
	CREATE_ACCOUNT_SUCCEED,
	UPDATE_ACCOUNT,
	UPDATE_ACCOUNT_FAILED,
	UPDATE_ACCOUNT_SUCCEED,
	DELETE_ACCOUNT,
	DELETE_ACCOUNT_FAILED,
	DELETE_ACCOUNT_SUCCEED,
	CHECK_SECURED_KEY,
	CHECK_SECURED_KEY_FAILED,
	CHECK_SECURED_KEY_SUCCEED,
} from "@/redux/Constant/payment/userAccount";
import { UserAccount } from "@/lib/interfaces";

const initialState: {
	accounts: UserAccount[];
	error: any;
	message: string;
	result: any;
} = {
	accounts: [],
	error: null,
	message: "",
	result: null,
};

export default function userAccountReducer(state = initialState, action: any) {
	switch (action.type) {
		// FETCH ALL
		case FETCH_ACCOUNTS:
			return { ...state };
		case FETCH_ACCOUNTS_FAILED:
			return {
				...state,
				error: action.error,
			};
		case FETCH_ACCOUNTS_SUCCEED:
			return {
				...state,
				accounts: action.data,
			};

		// FETCH BY USER
		case FETCH_ACCOUNT:
			return { ...state };
		case FETCH_ACCOUNT_FAILED:
			return {
				...state,
				error: action.error,
			};
		case FETCH_ACCOUNT_SUCCEED:
			return { ...state, accounts: action.data };

		// CREATE
		case CREATE_ACCOUNT:
			return { ...state };
		case CREATE_ACCOUNT_FAILED:
			return {
				...state,
				error: action.error,
			};
		case CREATE_ACCOUNT_SUCCEED:
			return {
				...state,
				accounts: [...state.accounts, action.data],
			};

		// UPDATE
		case UPDATE_ACCOUNT:
			return { ...state };
		case UPDATE_ACCOUNT_FAILED:
			return {
				...state,
				error: action.error,
			};
		case UPDATE_ACCOUNT_SUCCEED:
			const newUserAccountData: any = {
				securedKey: action.data.securedKey,
			};
			state.accounts.splice(
				state.accounts.findIndex(
					(item: UserAccount) =>
						item.accountNumber == action.data.accountNumber
				),
				1,
				newUserAccountData
			);

		// DELETE
		case DELETE_ACCOUNT:
			return { ...state };
		case DELETE_ACCOUNT_FAILED:
			return {
				...state,
				error: action.error,
			};
		case DELETE_ACCOUNT_SUCCEED:
			return {
				...state,
				accounts: state.accounts.filter(
					(items: any) =>
						items.accountnumber !== action.data.accountnumber
				),
			};

		// CHECK SECURED KEY
		case CHECK_SECURED_KEY:
			return { ...state };
		case CHECK_SECURED_KEY_FAILED:
			return {
				...state,
				accounts: action.data,
				message: action.message,
			};
		case CHECK_SECURED_KEY_SUCCEED:
			return {
				...state,
				error: action.error,
				message: action.message,
			};

		default:
			return { ...state };
	}
}
