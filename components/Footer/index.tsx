import React from 'react';
import { Layout } from 'antd';

const FooterComponent = () => {
  const { Footer } = Layout;
  return (
    <>
      {/* Footer */}
      <Footer style={{ textAlign: 'center' }}>Realta Hotels ©2023</Footer>
    </>
  );
};

export default (FooterComponent);