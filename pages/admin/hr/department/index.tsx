import LayoutAdmin from "@/components/Layout/admin";
import Head from "next/head";
import { useEffect, useState } from "react";
import { Col, Row, Space, Table, Input, Button, Dropdown, Menu, Popconfirm, message } from "antd";
import { MoreOutlined, PlusOutlined, QuestionCircleOutlined } from '@ant-design/icons';
export default function HRDepartment() {
    return (
        <>
            <Head>
                <title>Human Resources </title>
            </Head>
            <LayoutAdmin>
                Layout Admin
            </LayoutAdmin>
        </>
    );
}