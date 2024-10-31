# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# Create courses

COURSES = [
  'Administração',
  'Ciência da Computação',
  'Engenharia Civil',
  'Engenharia de Software',
  'Direito',
  'Medicina',
  'Enfermagem',
  'Psicologia',
  'Contabilidade',
  'Marketing',
  'Publicidade e Propaganda',
  'Design Gráfico',
  'Educação Física',
  'Nutrição',
  'Farmácia',
  'Fisioterapia',
  'Biomedicina',
  'Odontologia',
  'Arquitetura e Urbanismo',
  'Jornalismo',
  'Relações Internacionais',
  'Economia',
  'Gestão de Recursos Humanos',
  'Logística',
  'Análise e Desenvolvimento de Sistemas',
  'Ciência de Dados',
  'Sistemas de Informação',
  'Engenharia de Produção',
  'Engenharia Elétrica',
  'Engenharia Mecânica',
  'Engenharia Química',
  'Engenharia Ambiental',
  'Engenharia de Controle e Automação',
  'Engenharia de Alimentos',
  'Agronomia',
  'Zootecnia',
  'Veterinária',
  'Biologia',
  'Matemática',
  'Física',
  'Química',
  'História',
  'Geografia',
  'Letras',
  'Pedagogia',
  'Filosofia',
  'Sociologia',
  'Ciências Sociais',
  'Antropologia',
  'Artes Visuais',
  'Música',
  'Teatro',
  'Dança',
  'Tecnologia em Gestão Financeira',
  'Gestão Pública',
  'Gestão Comercial',
  'Gestão da Qualidade',
  'Gestão Hospitalar',
  'Gestão Ambiental',
  'Estatística',
  'Ciências Atuariais',
  'Secretariado Executivo',
  'Turismo',
  'Hotelaria',
  'Eventos',
  'Design de Moda',
  'Produção Audiovisual',
  'Cinema e Audiovisual',
  'Rádio e TV',
  'Produção Multimídia',
  'Geologia',
  'Meteorologia',
  'Oceanografia',
  'Ciências do Mar',
  'Engenharia de Petróleo e Gás',
  'Engenharia Naval',
  'Engenharia Aeronáutica',
  'Tecnologia da Informação',
  'Inteligência Artificial',
  'Robótica',
  'Tecnologia em Segurança do Trabalho',
  'Tecnologia em Redes de Computadores',
  'Banco de Dados',
  'Jogos Digitais',
  'Arquitetura de Software',
  'Big Data',
  'Cibersegurança',
  'Recursos Minerais',
  'Linguística',
  'Psicopedagogia',
  'Educação Especial',
  'Educação Infantil',
  'Serviço Social',
  'Desenvolvimento Sustentável',
  'Política e Gestão Pública',
  'História da Arte',
  'Comunicação Institucional',
  'Gestão Esportiva',
  'Ciências Forenses',
  'Horticultura',
  'Tecnologia em Agroecologia',
  'Engenharia Têxtil',
  'Tecnologia em Construção de Edifícios'
].freeze

LEVELS = [
  'Especialização (pós-graduação)',
  'MBA (pós-graduação)',
  'Bootcamp',
  'Segunda Graduação',
  'Sequencial',
  'Ensino Médio',
  'Ensino Infantil',
  'Ensino Fundamental',
  'Pré-vestibular',
  'Curso Livre',
  'Profissionalizante',
  'Técnico',
  'Pós-doutorado',
  'Doutorado',
  'Mestrado',
  'Pós-graduação Lato Sensu',
  'Pós-graduação',
  'Graduação',
  'Tecnólogo (graduação)',
  'Bacharelado + Licenciatura (graduação)',
  'Bacharelado (graduação)',
  'Licenciatura (graduação)',
  'Certificação Internacional',
  'Graduação Internacional',
  'Mestrado Internacional',
  'Pós-graduação Internacional',
  'Técnico Internacional'
].freeze

KINDS = [
  'Semidigital',
  'Híbrido',
  'Online',
  'Live',
  'Digital',
  'Presencial Flex',
  'Semipresencial',
  'Flex',
  'EaD',
  'Presencial',
  'Semi EaD',
].freeze

SHIFTS = [
  'Live',
  'Fim de Semana',
  'Outro',
  'Virtual',
  'Integral',
  'Noite',
  'Tarde',
  'Manhã',
].freeze

if Course.count.zero?
  100.times do
    Course.create!(
      name: COURSES.sample,
      level: LEVELS.sample,
      kind: KINDS.sample,
      shift: SHIFTS.sample
    )
  end
end

# Create university offers

ENROLLMENT_SEMESTER = [
  '2025.1',
  '2025.2',
  '2026.1',
  '2026.2',
]

Course.all.each do |course|
  next if course.university_offers.exists?

  2.times do
    UniversityOffer.create!(
      course: course,
      full_price: Faker::Number.decimal(l_digits: 3, r_digits: 2),
      max_payments: Faker::Number.between(from: 12, to: 60),
      enrollment_semester: ENROLLMENT_SEMESTER.sample
    )
  end
end

# Create offers

UniversityOffer.all.each do |university_offer|
  next if university_offer.offers.exists?

  2.times do
    Offer.create!(
      university_offer: university_offer,
      discount_percentage: Faker::Number.decimal(l_digits: 2, r_digits: 2),
      enabled: true
    )
  end

  Offer.create!(
    university_offer: university_offer,
    discount_percentage: Faker::Number.decimal(l_digits: 2, r_digits: 2),
    enabled: false
  )
end
