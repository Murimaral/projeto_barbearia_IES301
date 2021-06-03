module ApplicationHelper
  def species(species)
    species == 'dog' ? 'Cachorro' : 'Gato'
  end

  def sex(sex)
    sex == 'male' ? 'Macho' : 'Fêmea'
  end

  def status(status)
    status == 'found' ? 'Resgatado' : 'Perdido'
  end

  def rescue_status(status)
    strings = {
      open: 'Aberto',
      cancelled: 'Cancelado',
      refused: 'Recusado',
      accepted: 'Aceito'
    }
    strings[status.to_sym]
  end
end
