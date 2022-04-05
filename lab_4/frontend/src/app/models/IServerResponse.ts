export interface IServerResponse<T> {
  data: T[];
  meta: {
    pages: number;
  }
}
