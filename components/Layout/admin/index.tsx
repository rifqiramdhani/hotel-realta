import React from 'react';
import { Layout, theme } from 'antd';
import HeaderAdmin from '@/components/Header/admin';
import SidebarAdmin from '@/components/Sidebar/admin';
import FooterComponent from '@/components/Footer';
import IndicatorBreadcrumbEmployee from '@/components/Indicator/breadcrumb';
import { useRouter } from 'next/router';

const LayoutAdmin = ({ children }: any) => {
    const { Header, Content } = Layout;
    const {
        token: { colorBgContainer },
    } = theme.useToken();

    const router = useRouter();
    // const roleId: any = localStorage.getItem("roleId");
    // if (roleId != 4) {
    //   router.back();
    // }

    return (
        <>
            <Layout style={{ minHeight: '100vh' }}>
                <SidebarAdmin />

                <Layout className="site-layout">
                    <HeaderAdmin />

                    <Content style={{ margin: '0 16px' }}>
                        <IndicatorBreadcrumbEmployee />

                        <div style={{ padding: 24, minHeight: 360, background: colorBgContainer }}>
                            { children }
                        </div>
                    </Content>

                    {/* Footer */}
                    <FooterComponent />

                </Layout>
            </Layout>
        </>
    );
};

// export default PrivateWithAuth(LayoutAdmin);
export default LayoutAdmin