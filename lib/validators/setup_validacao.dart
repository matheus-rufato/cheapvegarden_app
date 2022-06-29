class SetupValidacao {
  String? validarUmidades(int? umidadeMaxima, int? umidadeMinima) {
    if (umidadeMaxima! <= umidadeMinima!) {
      return 'Umidade máxima menor ou igual a mínima!';
    } else {
      return null;
    }
  }

  String? validarUmidadeMinima(int umidadeMinima) {
    if (umidadeMinima >= 100) {
      return 'Umidade mínima maior ou igual à 100%';
    } else if (umidadeMinima < 0) {
      return 'Umidade mínima menor que 0%';
    } else {
      return null;
    }
  }

  String? validarUmidadeMaxima(int umidadeMaxima) {
    if (umidadeMaxima > 100) {
      return 'Umidade máxima maior à 100%';
    } else if (umidadeMaxima <= 0) {
      return 'Umidade máxima menor ou igual à 0%';
    } else {
      return null;
    }
  }
}
