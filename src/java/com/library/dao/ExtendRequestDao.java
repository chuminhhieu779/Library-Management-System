/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.dao;

import com.library.model.dto.ExtendRequestDTO;
import com.library.model.dto.ExtendRequestViewDTO;
import com.library.model.entity.ExtendRequest;
import java.util.List;

/**
 *
 * @author hieuchu
 */
public interface ExtendRequestDao {
    boolean insertExtendRequest(ExtendRequestDTO request) ;
    List<ExtendRequestViewDTO> getAllExtendRequests();
}
