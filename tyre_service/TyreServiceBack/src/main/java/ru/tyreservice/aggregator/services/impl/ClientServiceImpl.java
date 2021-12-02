package ru.tyreservice.aggregator.services.impl;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.tyreservice.aggregator.dto.requests.ClientDTO;
import ru.tyreservice.aggregator.entities.Client;
import ru.tyreservice.aggregator.exceptions.NotFoundException;
import ru.tyreservice.aggregator.repositories.ClientRepository;
import ru.tyreservice.aggregator.services.ClientService;

import java.util.Optional;

@Slf4j
@AllArgsConstructor
@Service
public class ClientServiceImpl implements ClientService {
    private final ClientRepository clientRepository;

    @Override
    public Long createNewClient(String email, String phone, String name) {
        Client client = new Client();
        client.setEmail(email);
        client.setName(name);
        client.setPhone(phone);
        return clientRepository.save(client).getId();
    }

    @Override
    public ClientDTO readClient(Long id) {
        Client client = findById(id);
        ClientDTO clientDTO = new ClientDTO();
        clientDTO.setEmail(client.getEmail());
        clientDTO.setName(client.getName());
        clientDTO.setPhone(client.getPhone());
        return clientDTO;
    }

    @Override
    @Transactional
    public void updateClient(Long id, ClientDTO clientDTO) {
        Client client = findById(id);
        String value = clientDTO.getName();
        if (!StringUtils.isBlank(value)) {
            client.setName(value);
        } else {
            clientDTO.setName(client.getName());
        }

        value = clientDTO.getPhone();
        if (!StringUtils.isBlank(value)) {
            client.setPhone(value);
        } else {
            clientDTO.setPhone(client.getPhone());
        }

        value = clientDTO.getEmail();
        if (!StringUtils.isBlank(value)) {
            client.setEmail(value);
        } else {
            clientDTO.setEmail(client.getEmail());
        }
    }


    private Client findById(Long id) {
        Optional<Client> optional = clientRepository.findById(id);
        return optional.orElseThrow(() -> new NotFoundException("Клиент с указанным идентификатором не существует"));
    }
}
