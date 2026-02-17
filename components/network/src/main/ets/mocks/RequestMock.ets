import { AxiosRequestConfig, HttpStatusCode } from '@ohos/axios'
import { axiosInstance } from '../apis/HttpRequest'
import AxiosMockAdapter from '@hw-agconnect/axios-mock-adapter'
import { getRecipeBriefInfoList } from './MockData/RecipeList'

const mock: AxiosMockAdapter = new AxiosMockAdapter(axiosInstance, {
  delayResponse: 300
})

mock.onGet('/recipe/list').reply(async (config: AxiosRequestConfig) => {
  let list = getRecipeBriefInfoList();
  const category: string = config.params?.category;
  const name: string = config.params?.name;
  if (category) {
    list = list.filter((item => item.category.includes(category)));
  }
  if (name) {
    list = list.filter((item => item.title.includes(name) || item.category.includes(name)));
  }

  return {
    status: HttpStatusCode.Ok,
    data: list,
  };
});