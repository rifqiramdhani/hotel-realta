import React, { useState } from "react";
import { Breadcrumb } from "antd";
import { useRouter } from "next/router";

const IndicatorBreadcrumbEmployee = () => {
  const router = useRouter();

  const { Item } = Breadcrumb;

  const path = router.asPath;
  const pathSplit = path.split('/')

  const ucwords = (str: string): any => {
    return (str + '').replace(/^([a-z])|\s+([a-z])/g, function ($1) {
      return $1.toUpperCase();
    });
  }

  return (
    <>
      {/* Breadcrumb */}
      <Breadcrumb style={{ margin: "16px 0" }}>
        { 
          pathSplit.map(((res, index) => {
            return (
              <>
                {index > 0 ? <Item>{ucwords(res)}</Item> : '' }
              </> 
              
            )
        }))}

      </Breadcrumb>
    </>
  );
};

export default IndicatorBreadcrumbEmployee;
