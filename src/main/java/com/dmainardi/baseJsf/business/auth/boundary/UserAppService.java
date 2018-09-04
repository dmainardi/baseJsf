/*
 * The MIT License
 *
 * Copyright 2018 Davide Mainardi <ingmainardi at live.com>.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package com.dmainardi.baseJsf.business.auth.boundary;

import com.dmainardi.baseJsf.business.auth.entity.GroupApp;
import com.dmainardi.baseJsf.business.auth.entity.UserApp;
import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;
import javax.ejb.Stateless;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.security.enterprise.identitystore.Pbkdf2PasswordHash;

/**
 *
 * @author Davide Mainardi <ingmainardi at live.com>
 */
@Stateless
public class UserAppService implements Serializable {
    @PersistenceContext
    EntityManager em;
    
    @Inject
    private Pbkdf2PasswordHash passwordHash;
    
    public UserApp find(String id) {
        return em.find(UserApp.class, id);
    }
    
    public boolean isUsernamePresent(String username) {
        return find(username) != null;
    }
    
    public void create(String username, String password) {
        GroupApp userGroup = em.find(GroupApp.class, "user");
        if (userGroup != null) {
            UserApp userApp = new UserApp();
            userApp.setUsername(username);
            userApp.setGroupApp(userGroup);
            
            Map<String, String> parameters = new HashMap<>();
            parameters.put("Pbkdf2PasswordHash.Iterations", "3072");
            parameters.put("Pbkdf2PasswordHash.Algorithm", "PBKDF2WithHmacSHA512");
            parameters.put("Pbkdf2PasswordHash.SaltSizeBytes", "64");
            passwordHash.initialize(parameters);
            
            userApp.setPassword(passwordHash.generate(password.toCharArray()));

            em.persist(userApp);
        }
    }
}
