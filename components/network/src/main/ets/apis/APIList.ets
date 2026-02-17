import { AxiosResponse } from "@ohos/axios";
import { QueryListParams, RecipeBriefInfo } from "../types/Recipe";
import { axiosInstance } from "./HttpRequest";
import '../mocks/RequestMock';

// 查询菜谱列表
export const queryRecipeList = (params?: QueryListParams): Promise<AxiosResponse<Array<RecipeBriefInfo>, void>> => {
  const url = '/recipe/list';
  return axiosInstance.get(url, {params});
}

