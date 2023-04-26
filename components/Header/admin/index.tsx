import { useRouter } from "next/router";
import { useDispatch } from "react-redux";
import * as React from 'react';
import 'react-toastify/dist/ReactToastify.css';
import ToastIndicator from "@/components/Indicator/toast";
import { Avatar, MenuProps } from 'antd';
import { Dropdown, Space } from 'antd';
import { DownOutlined, UserOutlined, LogoutOutlined } from '@ant-design/icons';

export default function HeaderAdmin() {
    const router = useRouter();
    // const userFullName: any = typeof window !== "undefined" ? localStorage.getItem('userFullName') : ''
    // const roleId: any = typeof window !== "undefined" ? localStorage.getItem('roleId') : ''
    // const userPhoto: any = typeof window !== "undefined" ? localStorage.getItem('userPhoto') : ''
    // const profilePhotoMe: any = typeof window !== "undefined" ? localStorage.getItem('profilePhotoMe') : ''
    // const profileNameMe: any = typeof window !== "undefined" ? localStorage.getItem('userFullNameNew') : ''

    // let myPhoto: any;
    // if (profilePhotoMe) {
    //     myPhoto = profilePhotoMe;
    // } else if (userPhoto != 'null') {
    //     myPhoto = userPhoto;
    // } else {
    //     myPhoto = "user.png";
    // }

    // let myName: any;
    // if (profileNameMe) {
    //     myName = profileNameMe;
    // } else if (userFullName != 'null') {
    //     myName = userFullName;
    // } else {
    //     myName = "Unknown";
    // }

    // let myRole: any;
    // if (roleId == 1) {
    //     myRole = "Guest";
    // } else if (roleId == 2) {
    //     myRole = "Manager";
    // } else if (roleId == 3) {
    //     myRole = "Office-Boy";
    // } else if (roleId == 4) {
    //     myRole = "Admin";
    // } else if (roleId == 5) {
    //     myRole = "Staff";
    // }

    const handleLogout = async () => {
        await router.push('/auth/signin');
        // await localStorage.removeItem('token');
        // await localStorage.removeItem('roleId');
        // await localStorage.removeItem('userId');
        // await localStorage.removeItem('userFullName');
        // await localStorage.removeItem('profilePhotoMe');
        // await localStorage.removeItem('userFullNameNew');
        // await localStorage.removeItem('userPhoto');
        // await ToastIndicator({ status: 'info', message: 'You have logged out' });
    };

    const handleProfile = () => {
        router.push('/admin/profile');
    };

    const items: MenuProps['items'] = [
        {
            key: '1',
            label: (
                <button
                    className="w-full text-left"
                    onClick={handleProfile}
                >
                    {"Profile"}
                </button>
            ),
            icon: (<UserOutlined />),
        },
        {
            key: '2',
            label: (
                <button
                    className="w-full text-left hover:text-red-500 hover:outline-none"
                    onClick={handleLogout}
                >
                    {"Sign Out"}
                </button>
            ),
            icon: (<LogoutOutlined />),
        },
    ];

    return (
        <div style={{ backgroundColor: '#F5F5F5' }}>
            <div className="pr-4 md:pr-4 text-pink-500 hover:text-pink-500 flex justify-end justify-items-center mt-2 text-center">
                <Dropdown menu={{ items }}>
                    <a onClick={(e) => e.preventDefault()} className="w-fit">
                        <Space>
                            <picture>
                                <Avatar src={<img src={"https://firebasestorage.googleapis.com/v0/b/hotel-realta.appspot.com/o/images%2F20230306T223029380Z914446.jpg?alt=media&token=75de57ea-0e06-4137-a060-66c534bb400b"} alt="avatar" />} size={{ xs: 24, sm: 32, md: 35, lg: 35}} />
                            </picture>
                            <span className="hidden md:block font-medium text-pink-600">
                                {'Rifqi' + " | " + 'Admin'}
                            </span>
                            <DownOutlined height={2} width={2} />
                        </Space>
                    </a>
                </Dropdown>
            </div>
        </div>
    );
}