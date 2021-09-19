require 'rails_helper'

feature 'Visitante acessa home' do
    scenario 'com sucesso' do
        #arrange
        #act
        visit root_path

        #assert
        expect(page).to have_content "Sistema de Gerenciamento Barbearia Luz do Mundo"
        expect(page).to have_content "Seja bem vindo(a)!!"

    end
end
