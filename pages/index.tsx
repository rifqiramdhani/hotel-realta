import {
  DesktopOutlined,
  FileOutlined,
  PieChartOutlined,
  TeamOutlined,
  MenuUnfoldOutlined,
  MenuFoldOutlined,
  UserOutlined,
} from '@ant-design/icons';
import React, { useState } from 'react';
import type { MenuProps } from 'antd';
import { Breadcrumb, Layout, Menu, theme } from 'antd';
import SidebarAdmin from '@/components/Sidebar/admin';
import HeaderAdmin from '@/components/Header/admin';
import IndicatorBreadcrumbEmployee from '@/components/Indicator/breadcrumb';
import FooterComponent from '@/components/Footer';

const { Header, Content, Footer, Sider } = Layout;
type MenuItem = Required<MenuProps>['items'][number];

function getItem(
  label: React.ReactNode,
  key: React.Key,
  icon?: React.ReactNode,
  children?: MenuItem[],
): MenuItem {
  return {
    key,
    icon,
    children,
    label,
  } as MenuItem;
}

export default function Home() {

  const {
    token: { colorBgContainer },
  } = theme.useToken();

  return (
    <Layout style={{ minHeight: '100vh' }}>
      <SidebarAdmin />

      <Layout className="site-layout">
        <HeaderAdmin />

        <Content style={{ margin: '0 16px' }}>
          <IndicatorBreadcrumbEmployee />

          <div style={{ padding: 24, minHeight: 360, background: colorBgContainer }}>
            Bill is a cat.
          </div>
        </Content>

        {/* Footer */}
        <FooterComponent />
        
      </Layout>
    </Layout>
  );
}
