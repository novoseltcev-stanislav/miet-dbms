import {HttpClient, HttpHeaders, HttpParams} from '@angular/common/http';
import {Injectable} from '@angular/core';
import {Observable} from 'rxjs';
import {Router} from "@angular/router";
import {IRoom} from "../models/IRoom";
import {IPatient} from "../models/IPatient";
import {IProcedure} from "../models/IProcedure";
import {IServerResponse} from "../models/IServerResponse";
import {environment} from "../../environments/environment";

export interface ApiRequestOptions {
  headers: Record<string, any>;
  params: Record<string, any>;
  reportProgress: boolean;
  observe: any;
  responseType: any;
  withCredentials: boolean;
}

export function getRequestOptions(options?: Partial<ApiRequestOptions>): Partial<ApiRequestOptions> | undefined {
  if (options) {
    let headers: Record<string, any> = options.headers ? options.headers : {};
    if (options.headers && !(headers instanceof HttpHeaders)) {
      headers = new HttpHeaders(headers);
    }

    let params: Record<string, any> = {};
    if (options.params) {
      params = new HttpParams();

      for (const propKey of Object.keys(options.params))
        if (options.params[propKey] !== undefined)
          params = params['append'](propKey, options.params[propKey] == null ? 'NULL' : options.params[propKey].toString());
    }

    return {...options, params, headers};
  }

  return;
}

@Injectable({
  providedIn: 'root',
})
export class RequestsService {
  constructor(private readonly httpClient: HttpClient, private router: Router) {
  }

  createUrl(url: string): string {
    if (url.indexOf('http') === 0 || url.indexOf('https') === 0)
      return url;
    return `${environment.baseUrl}${url}`;
  }

  get<T = void>(url: string, options?: Partial<ApiRequestOptions>): Observable<T> {
    return this.httpClient.get<T>(
      this.createUrl(url),
      getRequestOptions(options));
  }

  post<T = void>(url: string, body?: unknown | null, options?: Partial<ApiRequestOptions>): Observable<T> {
    return this.httpClient.post<T>(
      this.createUrl(url),
      body ?? null,
      getRequestOptions(options));
  }

  patch<T = void>(url: string, body: unknown | null, options?: Partial<ApiRequestOptions>): Observable<T> {
    return this.httpClient.patch<T>(
      this.createUrl(url),
      body,
      getRequestOptions(options));
  }

  put<T = void>(url: string, body: unknown | null, options?: Partial<ApiRequestOptions>): Observable<T> {
    return this.httpClient.put<T>(
      this.createUrl(url),
      body,
      getRequestOptions(options));
  }

  delete<T = void>(url: string, options?: Partial<ApiRequestOptions>): Observable<T> {
    return this.httpClient.delete<T>(
      this.createUrl(url),
      getRequestOptions(options));
  }


  getRooms(pageNumber?: number): Observable<IServerResponse<IRoom>> {
    const params: any = {};
    if (pageNumber || pageNumber === 0)
      params.page = pageNumber;
    return this.get('/rooms', {params});
  }

  getRoom(id: number): Observable<IRoom> {
    return this.get(`/rooms/${id}`);
  }

  createRoom(room: Partial<IRoom>): Observable<{ id: number }> {
    return this.post('/rooms', room);
  }

  editRoom(id: number, room: Partial<IRoom>) {
    return this.put(`/rooms/${id}`, room);
  }

  deleteRoom(id: number) {
    return this.delete(`/rooms/${id}`)
  }


  getPatients(pageNumber?: number): Observable<IServerResponse<IPatient>> {
    const params: any = {};
    if (pageNumber || pageNumber === 0)
      params.page = pageNumber;
    return this.get('/patients', {params})
  }

  getPatient(id: number): Observable<IPatient> {
    return this.get(`/patients/${id}`);
  }

  createPatient(patient: Partial<IPatient>): Observable<{ id: number }> {
    return this.post('/patients', patient);
  }

  editPatient(id: number, patient: Partial<IPatient>) {
    return this.put(`/patients/${id}`, patient);
  }

  deletePatient(id: number) {
    return this.delete(`/patients/${id}`)
  }


  getProcedures(pageNumber?: number): Observable<IServerResponse<IProcedure>> {
    const params: any = {};
    if (pageNumber || pageNumber === 0)
      params.page = pageNumber;
    return this.get('/procedures', {params})
  }

  getProcedure(id: number): Observable<IProcedure> {
    return this.get(`/procedures/${id}`);
  }

  createProcedure(procedure: Partial<IProcedure>): Observable<{ id: number }> {
    return this.post('/procedures', procedure);
  }

  editProcedure(id: number, procedure: Partial<IProcedure>) {
    return this.put(`/procedures/${id}`, procedure);
  }

  deleteProcedure(id: number) {
    return this.delete(`/procedures/${id}`)
  }

}
