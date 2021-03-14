import 'dart:io';

import 'package:dio/dio.dart';
import 'package:lojinha_virtual/models/cepaberto_address.dart';

const token = 'c106ce147b1e3cf3c16a886a3a1f4775';

class CepAbertoService {

  Future<CepAbertoAddress> getAddressFromCep(String cep) async {
    final cleanCep = cep.replaceAll('.', '').replaceAll('-', '');
    final endpoint = "https://www.cepaberto.com/api/v3/cep?cep=$cleanCep";

    final Dio dio = Dio();

    dio.options.headers[HttpHeaders.authorizationHeader] = 'Token token=$token';

    try {
      final response = await dio.get<Map<String, dynamic>>(endpoint);

      if(response.data.isEmpty){
        return Future.error('CEP Inválido');
      }

      final CepAbertoAddress address = CepAbertoAddress.fromMap(response.data);

      return address;

    } on DioError catch (e){
      return Future.error('Erro ao buscar CEP');
    }
  }
}