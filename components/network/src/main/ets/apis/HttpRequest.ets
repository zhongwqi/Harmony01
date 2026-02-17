import axios, { AxiosRequestConfig, AxiosResponse, InternalAxiosRequestConfig } from "@ohos/axios";

export const axiosInstance = axios.create({
  baseURL : '',
  timeout: 2 * 3000,
  headers: {}
})

axiosInstance.interceptors.request.use(
  (config: InternalAxiosRequestConfig) => {
    console.info('===== 拦截器看到的请求 =====');
    console.info('config.url:', config?.url);
    console.info('config.baseURL:', config?.baseURL);
    console.info('完整请求地址:' + config?.baseURL + config?.url);
    return config;
  }
);

axiosInstance.interceptors.response.use(
  (response: AxiosResponse) => {
    if (response.status === 200) {
      return Promise.resolve(response);
    } else {
      console.error(
        '[Network]'+
          `https request failed：${response.config.url}. error:`+
        JSON.stringify(response.status),
      );
      return Promise.reject(response);
    }
  },
  (error: BusinessError) => {
    console.error(
      '[Network]'+
        `https request failed：. error:`+
      JSON.stringify(error),
    );
    return Promise.reject(error);
  },
);