package com.kosta.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import com.gamecut.db.Init;

/**
 * Application Lifecycle Listener implementation class GameCutListener
 *
 */
@WebListener
public class GameCutListener implements ServletContextListener {

    /**
     * Default constructor. 
     */
    public GameCutListener() {
        // TODO Auto-generated constructor stub
    }

	/**
     * @see ServletContextListener#contextDestroyed(ServletContextEvent)
     */
    public void contextDestroyed(ServletContextEvent sce)  { 
         // TODO Auto-generated method stub
    }

	/**
     * @see ServletContextListener#contextInitialized(ServletContextEvent)
     */
    public void contextInitialized(ServletContextEvent sce)  { 
         // TODO Auto-generated method stub
    	Init.init();
    }
	
}
