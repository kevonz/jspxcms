package com.jspxcms.core.domaindsl;

import static com.mysema.query.types.PathMetadataFactory.*;

import com.jspxcms.core.domain.Admin;
import com.jspxcms.core.domain.Role;
import com.mysema.query.types.path.*;

import com.mysema.query.types.PathMetadata;

import com.mysema.query.types.Path;
import com.mysema.query.types.path.PathInits;


/**
 * QAdmin is a Querydsl query type for Admin
 */

public class QAdmin extends EntityPathBase<Admin> {

    private static final long serialVersionUID = 821773169;

    private static final PathInits INITS = PathInits.DIRECT;

    public static final QAdmin admin = new QAdmin("admin");

    public final NumberPath<Integer> id = createNumber("id", Integer.class);

    public final NumberPath<Integer> rank = createNumber("rank", Integer.class);

    public final SetPath<Role, QRole> roles = this.<Role, QRole>createSet("roles", Role.class, QRole.class, PathInits.DIRECT);

    public final QUser user;

    public QAdmin(String variable) {
        this(Admin.class, forVariable(variable), INITS);
    }

    @SuppressWarnings("all")
    public QAdmin(Path<? extends Admin> path) {
        this((Class)path.getType(), path.getMetadata(), path.getMetadata().isRoot() ? INITS : PathInits.DEFAULT);
    }

    public QAdmin(PathMetadata<?> metadata) {
        this(metadata, metadata.isRoot() ? INITS : PathInits.DEFAULT);
    }

    public QAdmin(PathMetadata<?> metadata, PathInits inits) {
        this(Admin.class, metadata, inits);
    }

    public QAdmin(Class<? extends Admin> type, PathMetadata<?> metadata, PathInits inits) {
        super(type, metadata, inits);
        this.user = inits.isInitialized("user") ? new QUser(forProperty("user"), inits.get("user")) : null;
    }

}

